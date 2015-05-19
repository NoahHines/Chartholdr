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

		#@kit = IMGKit.new(@output.html_safe, quality: 95, height: @height, width: @width, transparent: true, 'javascript-delay' => 9000)

		#send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')


		#kit = IMGKit.new(@output.html_safe, height: 900, transparent:true, quality:10)
		#kit.stylesheets << "/stylesheets/nv.d3.css"
		#file = kit.to_file(Rails.root + "public/pngs/" + "screenshot.png")
		#send_file("#{Rails.root}/public/pngs/screenshot.png", :filename => "screenshot.png", :type => "image/png",:disposition => 'attachment',:streaming=> 'true')



		
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
