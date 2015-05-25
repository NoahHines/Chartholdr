Rails.application.routes.draw do

  root 'application#index'

  get '/home', to: 'application#home'

  get '/pie/:width/:height', to: 'application#pie'
  get '/pie/:width', to: 'application#pie'

  get '/bar/:width/:height', to: 'application#bar'
  get '/bar/:width', to: 'application#bar'

  get '/line/:width/:height', to: 'application#line'
  get '/line/:width', to: 'application#line'

end
