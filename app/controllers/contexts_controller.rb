class ContextsController < ApplicationController

  def new
    @context = current_user.contexts.new
  end

  def edit
    @context = current_user.contexts.find(params[:id])
  end

  def create
    @context = current_user.contexts.new(params[:context])
    respond_to do |format|
      if @context.save
        format.html { redirect_to tasks_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @context = current_user.contexts.find(params[:id])
    respond_to do |format|
      if @context.update_attributes(params[:context])
        format.html { redirect_to tasks_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @context = current_user.contexts.find(params[:id])
    @context.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
    end
  end
end