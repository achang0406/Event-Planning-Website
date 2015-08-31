class UsersController < ApplicationController
  before_action :logged_in, only: [:index, :create, :login]
  def index
  end
  
  def create
  	user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], location: params[:location], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
  	if user.save
  		flash[:errors] = ["You have successfully created an account!"]
  	else
  		flash[:errors] = user.errors.full_messages
  	end
  	redirect_to '/users'
  end

  def login
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to '/events'
  	else
  		flash[:errors] = ["Sorry please try again."]
		redirect_to '/users'
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to '/users'
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.first_name = params[:first_name]
  	user.last_name = params[:last_name]
  	user.email = params[:email]
  	user.location = params[:location]
  	user.state = params[:state]

  	if user.save
  		flash[:errors] = ["Profile Updated!"]
	  	redirect_to '/events'
	else
		flash[:errors] = user.errors.full_messages
		redirect_to "/users/#{session[:user_id]}/edit"
  	end
  end
end
