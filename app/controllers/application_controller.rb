# Chartholdr.io
# Author: Noah Hines
# File: application_controller.rb

require 'phantomjs'
require 'fileutils'

class ApplicationController < ActionController::Base

	# set constants
	before_filter :set_constants
	def set_constants
		@force_cache = false
	 	@max_width = 5000 #default constraint is 5000x5000 image
	 	@max_height = 5000

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

		# Color Handling
		# ---------------
		# If no color parameter given, make @color="" and use default
		# Chartholdr color palette.
		#
		# example: params[:color] = c=ffffff or c=fff
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
	end

	def bar
		bar = Chart.new("bar", @width, @height, @color)
		generator = Generator.new(bar, @force_cache)
		send_data(File.open(generator.get).read, :type => "image/png", :disposition => 'inline')
	end

	def line
		line = Chart.new("line", @width, @height, @color)
		generator = Generator.new(line, @force_cache)
		send_data(File.open(generator.get).read, :type => "image/png", :disposition => 'inline')
	end

	def pie
		pie = Chart.new("pie", @width, @height, @color)
		generator = Generator.new(pie, @force_cache)
		send_data(File.open(generator.get).read, :type => "image/png", :disposition => 'inline')
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
