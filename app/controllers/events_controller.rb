class EventsController < ApplicationController
  before_action :require_login, only: [:index, :create, :show, :comment]
  def index
  	@user = User.find(session[:user_id])
  	@eventsInState = Event.where(state: @user.state)
  	@eventsOutState = Event.where.not(state: @user.state)
  end

  def create
  	event = Event.new(user_id: session[:user_id], name: params[:name], date: params[:date], location: params[:location], state: params[:state])
  	if !event.save
  		flash[:errors] = event.errors.full_messages
  	end
	redirect_to '/events'
  end

  def show
  	@event = Event.find(params[:id])
  	@joins = Join.where(event_id: @event.id)
    @comments = Comment.where(event_id: params[:id]).order(created_at: :desc)
  end

  def comment
    comment = Comment.new(user_id: session[:user_id], event_id: params[:id], comment: params[:comment])
    puts "new comment"
    if !comment.save
      flash[:errors] = comment.errors.full_messages
      puts "error"
    end
    redirect_to "/events/#{params[:id]}"
  end
end
