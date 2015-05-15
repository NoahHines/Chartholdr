class ApplicationController < ActionController::Base
	def hello
		render text: "Welcome to Chartholdr. Here's an example url: http://localhost:3000/bar/800/700"
	end

	def bar

		#generator=generator.new(300, 900)
		@gen = Generator.new(300, 900)

		@width = params[:width]
		@height = params[:height]

		@kit = IMGKit.new(@gen.getHTML, quality: 95, height: @height, width: @width, transparent: true)

		send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')
		
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
