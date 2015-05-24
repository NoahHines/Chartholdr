Rails.application.routes.draw do

  root 'application#home'

  get '/home', to: 'application#home'

  get '/pie/:width/:height', to: 'application#pie'
  get '/pie/:width', to: 'application#pie'

  get '/bar/:width/:height', to: 'application#bar'

  get '/line/:width/:height', to: 'application#line'

end
