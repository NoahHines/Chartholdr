# Chartholdr.io
# Author: Noah Hines
# File: chart_spec.rb

require "rails_helper"  # this
require "chart"
require "generator"

#libraries
require 'fastimage'

describe Chart do

	# Basic Constructors
	it "is a pie by default" do
		chart = Chart.new
		chart.type.should == "pie"
	end

	it "can be a pie" do
		chart = Chart.new("pie")
		chart.type.should == "pie"
	end

	it "can be a bar" do
		chart = Chart.new("bar")
		chart.type.should == "bar"
	end

	it "can be a line" do
		chart = Chart.new("line")
		chart.type.should == "line"
	end

	it "will be a pie if unknown type is given" do
		chart = Chart.new("crazy")
		chart.type.should == "pie"
	end

	it "will be correct size" do
		chart = Chart.new("pie", 400, 400)
		FastImage.size(chart.get)[0].should == 400
		FastImage.size(chart.get)[1].should == 400
		chart = Chart.new("bar", 505, 500)
		FastImage.size(chart.get)[0].should == 505
		FastImage.size(chart.get)[1].should == 500
		chart = Chart.new("line", 700, 200)
		FastImage.size(chart.get)[0].should == 700
		FastImage.size(chart.get)[1].should == 200
	end
	
end


