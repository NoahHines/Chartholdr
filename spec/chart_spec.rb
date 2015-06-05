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

	it "can call generator from a method call" do
		chart = Chart.new("pie", 300, 300)

	end

	it "will be correct size" do
		pie_gen = Generator.new(Chart.new("pie", 400, 400))
		FastImage.size(pie_gen.get)[0].should == 400
		FastImage.size(pie_gen.get)[1].should == 400
		bar_gen = Generator.new(Chart.new("bar", 505, 500))
		FastImage.size(bar_gen.get)[0].should == 505
		FastImage.size(bar_gen.get)[1].should == 500
		line_gen = Generator.new(Chart.new("line", 700, 200))
		FastImage.size(line_gen.get)[0].should == 700
		FastImage.size(line_gen.get)[1].should == 200
	end	
end