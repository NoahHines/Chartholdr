require 'phantomjs'

require 'fileutils'

class ApplicationController < ActionController::Base

	# set constants
	before_filter :set_constants
	def set_constants

	 	@max_width = 5000 #default constraint is 5000x5000 image
		@max_height = 5000

		# final image path
		@final_path = ""

		# Dimension Handling
		# ---------------
		# If height is not specified, assume square
		@width = params[:width]
		if params[:height] != nil
			if !(5 < params[:height].to_i && params[:height].to_i <= 5000)
				@height = @width
			else
				@height = params[:height]
			end
			# Constraints added so the server doesn't get murdered
			if (@width.to_i > @max_width || @height.to_i > @max_height)
				return
			end
		else
			@height = @width
			@color =""
		end

		# adjusted width and heights -8 and -18 due to default css margins
		@width_a = (@width.to_i-8).to_s
		@height_a = (@height.to_i-16).to_s

		# Color Handling
		# ---------------
		# If no color parameter given, make @color="" and use default
		# Chartholdr color palette.
		#
		# example: params[:color] = c=ffffff
		if params[:color] != nil
			if (params[:color].length == 5 || params[:color].length == 8)
				@color = params[:color][2,params[:color].length-1]
			else
				@color = ""
			end
		else
			if params[:height] != nil
				if (params[:height].length == 5 || params[:height].length == 8)
					@color = params[:height][2,params[:height].length-1]
				else
					@color = ""
				end
			end
		end
		# Convert color to proper length 6
		if @color.length === 3
			@color = (@color.to_s + @color.to_s)
			@color_new = @color[0] + @color[0]
			@color_new += @color[1] + @color[1]
			@color_new += @color[2] + @color[2]
			@color = @color_new
		end

		# if in prod, check if image already exists.
		if Rails.env.production?
			@color_string = ""
			if !@color === ""
				@color_string = @color + "/"
			end
			@final_path = "#{Rails.root}" + "/public/" + @width.to_s + '/' + @height.to_s + '/' + @color_string.to_s
			if File.exist?(@final_path + "chart.png")
				send_data(File.open(@final_path + "chart.png").read, :type => "image/png", :disposition => 'inline')
			end
		end

	end

	def get_binding # helper method to access the objects binding method
	    binding
	  end

	# Home page
	def home

	end

	def bar
		@layout_type = "bar"
		render_it(@layout_type)
	end

	def line
		@layout_type = "line"
		render_it(@layout_type)
	end

	def pie
		@layout_type = "pie"
		render_it(@layout_type)
	end

	def create_file(path, extension)
	  dir = File.dirname(path)

	  unless File.directory?(dir)
	    FileUtils.mkdir_p(dir)
	  end

	  path << ".#{extension}"
	  File.new(path, 'w')
	end

	# Amount should be a decimal between 0 and 1. Lower means darker
	def darken_color(hex_color, amount=0.4)
	  hex_color = hex_color.gsub('#','')
	  rgb = hex_color.scan(/../).map {|color| color.hex}
	  rgb[0] = (rgb[0].to_i * amount).round
	  rgb[1] = (rgb[1].to_i * amount).round
	  rgb[2] = (rgb[2].to_i * amount).round
	  "#%02x%02x%02x" % rgb
	end

	# Amount should be a decimal between 0 and 1. Higher means lighter
	def lighten_color(hex_color, amount=0.6)
	  hex_color = hex_color.gsub('#','')
	  rgb = hex_color.scan(/../).map {|color| color.hex}
	  rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
	  rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
	  rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
	  "#%02x%02x%02x" % rgb
	end

	private
		def render_it(layout = "pie") #default chart is pi
			#TODO move this logic to generator class
			#TODO add support for SVGs

			html = File.open("#{Rails.root}/app/views/layouts/"+layout.to_s+"_layout.html.erb").read
		    template = ERB.new(html)
			template = template.result(get_binding).html_safe

			# @tempFile is the generated HTML file that calls Pizza.init()
			@templateFile = Tempfile.new(['templatefile', '.html'], "#{Rails.root}/tmp")
			@templateFile.write(template)
			File.chmod(444, @templateFile.path)
			@templateFile.rewind

			# Create temp image to send
			@tempImageFile = Tempfile.new(['image', '.png'], "#{Rails.root}/tmp")

			# data object is used to pass in parameters into the js file
			data = {"width" => @width, "height" => @height,
				"template" => @templateFile.path, "image" => @tempImageFile.path}.to_json
			dataFile = Tempfile.new(['data', '.txt'], "#{Rails.root}/tmp")
			dataFile.write(data)
			File.chmod(444, dataFile.path)
			dataFile.rewind

			Phantomjs.run("#{Rails.root}/phantom/render.js", dataFile.path)

			# if in prod, save image to public folder
			if Rails.env.production?
				FileUtils.mkdir_p @final_path unless File.exists?(@final_path)
				File.rename(@tempImageFile.path, @final_path + "chart.png")
				send_data(File.open(@final_path + "chart.png").read, :type => "image/png", :disposition => 'inline')
			else
				# Send file inline
				send_data(File.open(@tempImageFile.path).read, :type => "image/png", :disposition => 'inline')
			end

		end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
