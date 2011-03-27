class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  before_filter :require_user
  
  private
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end
    
  def require_user
    redirect_to(root_path, :alert => "Please login to continue.") unless current_user  
    return false
  end

end