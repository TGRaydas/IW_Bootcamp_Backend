class MainController < ApplicationController
	skip_before_action :verify_authenticity_token  

	include MainHelper
	def index
		#require 'socket'
		#sock = TCPSocket.new('0.0.0.0', 2345)
		#sock.write 'GETHELLO'
		#sock.close
	end
	
	def value
		container = Container.find(params[:code])
		last_buy = container.last_buy
		last_update = container.updated_at.to_s.split
		last_update_date = container.updated_at.to_s.split[0]
		last_update_time = container.updated_at.to_s.split[1]
		render json: {value: container.value, last_update_time: last_update_time, last_update_date: last_update_date, last_buy: last_buy}
	end

	def buy
		container = Container.find(params[:id])
		Buy.create(container: container, amount: params[:count])
		last_buy = container.last_buy
		last_update_date = container.updated_at.to_s.split[0]
		last_update_time = container.updated_at.to_s.split[1]
		container.update(value: container.value + 1, total: container.total + params[:count].to_i, last_buy: params[:count].to_i)
		render json: {value: container.value, last_update_time: last_update_time, last_update_date: last_update_date, last_buy: last_buy}
	end

	def all_buys
		container = Container.find(params[:id])
		buys = container.buys

		render json: {data: buys}
	end

end
