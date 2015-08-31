class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def logged_in
  	redirect_to '/events' if session[:user_id]
  end
  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def joined_event event_id
  	Join.find_by(user_id: session[:user_id], event_id: event_id) if session[:user_id]
  end
  helper_method :joined_event
  def require_login
    redirect_to '/users' if session[:user_id] == nil
  end
end
