class JoinsController < ApplicationController
	def join
		Join.create(user_id: session[:user_id], event_id: params[:id])
		redirect_to '/events'
	end

	def cancel
		join = Join.find_by(user_id: session[:user_id], event_id: params[:id])
		join.destroy
		redirect_to '/events'
	end
end