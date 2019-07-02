Rails.application.routes.draw do
	root 'main#index'
	post '/value', to: "main#value"
	post '/buy', to: "main#buy"
	get '/history/:id', to: "main#all_buys"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
