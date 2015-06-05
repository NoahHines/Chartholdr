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
	end

	def color
		return @color
	end

end