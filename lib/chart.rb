# Chartholdr.io
# Author: Noah Hines
# File: chart.rb

require "generator"

class Chart
	attr_accessor :type,:width,:height,:color

	def initialize(type = 'pie', width = '400', height = '400', color = '')
		@type = 'pie'
		if (type == 'pie' || type == 'bar' || type == 'line')
			@type = type
		end
		@width = width
		@height = height
		@color = color
		@color_string = ""
		@final_path = ""
	end

	def get
		# if in prod, check if image already exists.
		if Rails.env.production?
			if @color != ""
				@color_string = @color + "/"
			end
			@final_path = "#{Rails.root}" + "/public/" + @type + '/' + @width.to_s + '/' + @height.to_s + '/'

			if (File.exist?(@final_path + "chart.png") && @color === "") # if file exists for no color...
				return @final_path + "chart.png"
			else
				# create color folder unless it already exists
				FileUtils.mkdir_p (@final_path + @color_string) unless File.exists?(@final_path + @color_string)
				# if there file exists for a color...
				if (File.exist?(@final_path + @color_string + "chart.png")  && @color != "")
					return @final_path + @color_string.to_s + "chart.png"
				end
			end
		end
		# Since there is not a cached color or non-color image, create a generator
		# and render a new image
		generator = Generator.new(self)
		return generator.render
	end

	def get_image
		return File.open(get)
	end

	def final_path
		return @final_path
	end
	def color_string
		return @color_string
	end
	def color
		return @color
	end
end