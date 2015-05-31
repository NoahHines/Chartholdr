# Chartholdr.io
# Author: Noah Hines
# File: generator.rb

# define class Generator
class Generator
	def initialize(chart)
	    # Instance variables
	    @chart = chart
	end

	def get_binding # helper method to access the objects binding method
		binding
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

    def render
		html = File.open("#{Rails.root}/app/views/layouts/"+@chart.type.to_s+"_layout.html.erb").read
		template = ERB.new(html)

		template = template.result(get_binding).html_safe

		# @templateFile is the generated HTML file that calls Pizza.init()
		@templateFile = Tempfile.new(['templatefile', '.html'], "#{Rails.root}/tmp")
		@templateFile.write(template)
		File.chmod(444, @templateFile.path)
		@templateFile.rewind

		# Create temp image to send
		@tempImageFile = Tempfile.new(['image', '.png'], "#{Rails.root}/tmp")

		# data object is used to pass in parameters into the js file
		data = {"width" => @chart.width, "height" => @chart.height,
			"template" => @templateFile.path, "image" => @tempImageFile.path}.to_json
		dataFile = Tempfile.new(['data', '.txt'], "#{Rails.root}/tmp")
		dataFile.write(data)
		File.chmod(444, dataFile.path)
		dataFile.rewind

		Phantomjs.run("#{Rails.root}/phantom/render.js", dataFile.path)

		# if in prod, save image to public folder
		if Rails.env.production?
			FileUtils.mkdir_p @chart.final_path unless File.exists?(@chart.final_path)
			# if no color specified...
			if @color===""
				File.rename(@tempImageFile.path, @chart.final_path + "chart.png")
				return @chart.final_path + "chart.png"
			# otherwise, place color image in new subfolder
			else
				FileUtils.mkdir_p (@chart.final_path + @chart.color_string) unless File.exists?(@chart.final_path + @chart.color_string)
				File.rename(@tempImageFile.path, @chart.final_path + @chart.color_string + "chart.png")
				return @chart.final_path + @chart.color_string + "chart.png"
			end

		else
			# if not in prod, return file inline without caching
			return @tempImageFile.path
		end
	end
end