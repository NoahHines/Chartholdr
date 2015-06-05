# Chartholdr.io
# Author: Noah Hines
# File: chart_spec.rb

require "rails_helper"  # this
require "chart"
require "generator"

describe Generator do

	it "knows what chart it has" do
		chart = Chart.new("pie")
		gen = Generator.new(chart)
		gen.get_chart.type.should == "pie"
	end
end