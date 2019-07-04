class MainController < ApplicationController
	skip_before_action :verify_authenticity_token  
	require 'date'
	include MainHelper
	def index
		#require 'socket'
		#sock = TCPSocket.new('0.0.0.0', 2345)
		#sock.write 'GETHELLO'
		#sock.close
	end
	
	def value
		container = Container.find(params[:code])
		buys = Buy.where(container_id: container.id, )
		last_buy = container.last_buy
		last_update = container.updated_at.to_s.split
		last_update_date = container.updated_at.to_s.split[0]
		last_update_time = container.updated_at.to_s.split[1]
		now_month = Date.today.month
		total = 0
		buys.each do |b|
			if b.created_at.month > now_month - 1
				if b.amount != nil
					total += b.amount
				end
			end
		end
		render json: {value: container.value, , total: total,last_update_time: last_update_time, last_update_date: last_update_date, last_buy: last_buy}
	end

	def buy
		container = Container.find(params[:id])
		Buy.create(container: container, amount: params[:count])
		now_month = Date.today.month
		total = 0
		buys = Buy.where(container_id: 1)
		buys.each do |b|
			if b.created_at.month > now_month - 1
				if b.amount != nil
					total += b.amount
				end
			end
		end
		last_buy = container.last_buy
		last_update_date = container.updated_at.to_s.split[0]
		last_update_time = container.updated_at.to_s.split[1]
		container.update(value: container.value + 1, total: container.total + params[:count].to_i, last_buy: params[:count].to_i)
		render json: {value: container.value, total: total,last_update_time: last_update_time, last_update_date: last_update_date, last_buy: last_buy}
	end

	def buy_points
		container = Container.find(params[:id])
		Buy.create(container: container, amount: params[:count])
		last_buy = container.last_buy
		last_update_date = container.updated_at.to_s.split[0]
		last_update_time = container.updated_at.to_s.split[1]
		container.update(value: container.value - params[:count].to_i, total: container.total + params[:count].to_i, last_buy: params[:count].to_i)
		render json: {value: container.value, last_update_time: last_update_time, last_update_date: last_update_date, last_buy: last_buy}
	end

	def all_buys
		container = Container.find(params[:id])
		buys = container.buys

		render json: {data: buys}
	end

	def get_device
		dispenser = Dispenser.find(params[:id])
		render json: {data: dispenser.ble_id}
	end

	def get_info
	  pdf_filename = File.join(Rails.root, "app/views/main/file.pdf")
	  send_file(pdf_filename, :filename => "file.pdf", :type => "application/pdf")
	end

end
