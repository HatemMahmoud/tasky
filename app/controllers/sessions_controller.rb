class SessionsController < ApplicationController
  skip_before_filter :require_user
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id  
    redirect_to tasks_path
  end
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url  
  end
  
  def failure 
    redirect_to root_url, :alert => 'Login faild! Please try again.'
  end
end