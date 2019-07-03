Rails.application.routes.draw do
	root 'main#index'
	post '/value', to: "main#value"
	post '/buy', to: "main#buy"
	get '/history/:id', to: "main#all_buys"
	get '/link/device/:id', to: "main#get_device"
	get '/info', to: "main#get_info"
	post '/buy/points', to: "main#buy_points"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
