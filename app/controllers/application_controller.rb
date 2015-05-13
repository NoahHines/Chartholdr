class ApplicationController < ActionController::Base

	def hello
		render text: "Welcome to Chartholdr. Here's an example url: http://localhost:3000/bar/800/700"
	end

	def bar

		@width = params[:width]
		@height = params[:height]

		@kit = IMGKit.new('http://nvd3.org/examples/linePlusBar.html', quality: 80, height: @height, width: @width)

		send_data(@kit.to_jpg, :type => "image/jpeg", :disposition => 'inline')
		
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
