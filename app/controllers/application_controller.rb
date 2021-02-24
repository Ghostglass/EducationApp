class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authenticate_user!

  def authenticate_user!
    session[:user_id] ||= 1 if ENV['RAILS_ENV'] == 'test'
    # during tests, user_id = 1
    
    if session[:user_id].nil?
      flash[:warning] = 'Please log in'
      redirect_to login_path
    end
  end

  def is_owner
    @is_owner = @course.user_id == session[:user_id]
  end

  def only_permit_owner
    unless @is_owner
      flash[:warning] = "Only the course owner can do this. If you are the course owner, please log in."
      redirect_back fallback_location: "/"
    end
  end

end
