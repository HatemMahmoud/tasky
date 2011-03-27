class PagesController < ApplicationController
  skip_before_filter :require_user
  
  def show
    render :template => "pages/#{params[:id].to_s.downcase}"
  end
end