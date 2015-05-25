require 'phantomjs'
#require 'carrierwave/orm/activerecord'

class ApplicationController < ActionController::Base

	# chart uploader using carrierwave
	  #mount_uploader :chart, ChartUploader

	# set constants
	before_filter :set_constants
	def set_constants
	 	@max_width = 5000 #default constraint is 5000x5000 image
		@max_height = 5000

		# If height is not specified, assume square
		@width = params[:width]
		if !(5 < params[:height].to_i && params[:height].to_i <= 5000)
			@height = @width
		else
			@height = params[:height]
		end

		# -8 and -18 due to default css margins
		@width_a = (@width.to_i-8).to_s
		@height_a = (@height.to_i-16).to_s

		# Constraints added so the server doesn't get murdered
		if (@width.to_i > @max_width || @height.to_i > @max_height)
			return
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

	private
		def render_it(layout = "pie") #default chart is pi
			#TODO move this logic to generator class
			#TODO add support for SVGs

			html = File.open("#{Rails.root}"+"/app/views/layouts/"+layout.to_s+"_layout.html.erb").read
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
			data = {"width" => @width, "height" => @height, "template" => @templateFile.path, "image" => @tempImageFile.path}.to_json
			dataFile = Tempfile.new(['data', '.txt'], "#{Rails.root}/tmp")
			dataFile.write(data)
			File.chmod(444, dataFile.path)
			dataFile.rewind

			Phantomjs.run("#{Rails.root}"+"/phantom/render.js", dataFile.path)

			# Send file inline
			send_data(File.open(@tempImageFile.path).read, :type => "image/png", :disposition => 'inline')

		end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
