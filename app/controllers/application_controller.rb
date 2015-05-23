require 'phantomjs'

class ApplicationController < ActionController::Base

	def get_binding # this is only a helper method to access the objects binding method
	    binding
	  end

	def hello
		render text: "Welcome to Chartholdr. Here's an example url: http://localhost:3000/bar/800/700"
	end

	# Home page
	def home

	end

	def pie
		#TODO move this logic to generator class
		#TODO add support for SVGs

		# -8 and -18 due to default body margins
		@width = params[:width]
		@height = params[:height]
		@width_a = (params[:width].to_i-8).to_s
		@height_a = (params[:height].to_i-16).to_s

		html = File.open("app/views/layouts/pie_layout.html.erb").read
	    template = ERB.new(html)
		template = template.result(get_binding).html_safe

		# @tempFile is the generated HTML file that calls Pizza.init()
		@templateFile = Tempfile.new(['templatefile', '.html'], "#{Rails.root}/tmp")
		@templateFile.write(template)
		File.chmod(444, @templateFile.path)
		@templateFile.rewind

		# data object is used to pass in parameters into the js file
		data = {"width" => @width, "height" => @height, "template" => @templateFile.path}.to_json
		dataFile = Tempfile.new(['data', '.txt'], "#{Rails.root}/tmp")
		dataFile.write(data)
		File.chmod(444, dataFile.path)
		dataFile.rewind

		Phantomjs.run("./phantom/render.js", dataFile.path)

		# Send file inline
		send_data(File.open("google_home.png").read, :type => "image/png", :disposition => 'inline')

		
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
