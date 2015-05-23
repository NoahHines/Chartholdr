Rails.application.routes.draw do

  root 'application#home'

  get '/home', to: 'application#home'

  #get '/bar/:id', to: 'application#bar', id: 3

  #get '/bar/:tag', to: 'application#bar', as: :tagged_products

  #match 'bar/:name', :to => 'application#bar'

  get '/pie/:width/:height', to: 'application#pie'

  get '/bar/:width/:height', to: 'application#bar'

  get '/line/:width/:height', to: 'application#line'

end
