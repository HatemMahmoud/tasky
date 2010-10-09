class UserSessionsController < ApplicationController
  skip_before_filter :require_user
  skip_before_filter :verify_authenticity_token, :only => :create
  
  # login
  def create
    rpxnow_data = RPXNow.user_data(params[:token])
    new_user_data = {:identifier => rpxnow_data[:identifier], :name => rpxnow_data[:name], :email => rpxnow_data[:email]}
    # existing user
    if self.current_user = User.find_by_identifier(new_user_data[:identifier])
      flash[:notice] = 'Welcome back!'
      redirect_back_or_default root_path
    else
      # new user
      new_user = User.new(new_user_data)
      if new_user.save
        self.current_user = new_user
        flash[:notice] = 'Thanks for signing up!'
        redirect_back_or_default root_path
      else
        # invalid user
        session[:new_user_data] = new_user_data
        redirect_to new_user_path, :alert => 'Please complete required data to continue.'
      end
    end
  rescue
    # login failed or canceled
    redirect_to root_path, :alert => 'Login failed! Please try again.'
  end
  
  # logout
  def destroy
    self.current_user = nil
    redirect_to root_path
  end
end
