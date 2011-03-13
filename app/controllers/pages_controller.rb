class PagesController < ApplicationController
  def show
    render :template => "pages/#{params[:id].to_s.downcase}"
  end
end