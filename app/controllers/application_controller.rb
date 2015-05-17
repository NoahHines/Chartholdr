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

	def bar

		#@gen = Generator.new(300, 900, 0)

		@width = params[:width]
		@height = params[:height]

		html = File.open("app/views/application/pie_template.html.erb").read
	    template = ERB.new(html)
	    template.result

        @output = template.result(get_binding)

        #render :text => @output
        render html: @output.html_safe

		#@kit = IMGKit.new(template.result(get_binding), quality: 95, height: @height, width: @width, transparent: true)

		#send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')
		
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
