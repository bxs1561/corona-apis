Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/corona', to:'apis#corona_api'
  get '/all', to:'apis#corona_virus'
  get '/country', to:'apis#country_api'


end
