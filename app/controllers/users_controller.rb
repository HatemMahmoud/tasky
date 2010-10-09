class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    if session[:new_user_data].blank?
      redirect_to root_path
    else
      @user = User.new session[:new_user_data]
      session[:new_user_data] = nil
    end
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      flash[:notice] = 'Thanks for signing up!'
      redirect_back_or_default root_path
    else
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_path, :notice => 'User was successfully updated.'
    end
  end

end