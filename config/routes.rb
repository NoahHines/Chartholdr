Rails.application.routes.draw do

  # WIP 404 page =)
  # if Rails.env.production?
  #    get '404', :to => 'application#page_not_found'
  # end

  root 'application#home'

  get '/home', to: 'application#home'

  # :height could also be color. We must check if :height is a string of
  # format "c=ffffff", where "ffffff" is a hex color value of length 3 5 or 6

  # gray routes
  get '/g/bar/:width/:height', to: 'application#bar_g'
  get '/g/bar/:width', to: 'application#bar_g'
  get '/g/bar/:width/:height/:color', to: 'application#bar_g'

  get '/g/line/:width/:height', to: 'application#line_g'
  get '/g/line/:width', to: 'application#line_g'
  get '/g/line/:width/:height/:color', to: 'application#line_g'

  get '/g/pie/:width/:height', to: 'application#pie_g'
  get '/g/pie/:width', to: 'application#pie_g'
  get '/g/pie/:width/:height/:color', to: 'application#pie_g'

  

  get '/pie/:width/:height', to: 'application#pie'
  get '/pie/:width', to: 'application#pie'
  get '/pie/:width/:height/:color', to: 'application#pie'

  get '/bar/:width/:height', to: 'application#bar'
  get '/bar/:width', to: 'application#bar'
  get '/bar/:width/:height/:color', to: 'application#bar'

  get '/line/:width/:height', to: 'application#line'
  get '/line/:width', to: 'application#line'
  get '/line/:width/:height/:color', to: 'application#line'

end
