class ContextsController < ApplicationController
  
  def new
    @context = current_user.contexts.new
  end

  def edit
    @context = current_user.contexts.find params[:id]
  end

  def create
    @context = current_user.contexts.new params[:context]
    if @context.save
      redirect_to tasks_path, :notice => 'Context was successfully created.'
    else
      render :new
    end
  end

  def update
    @context = current_user.contexts.find params[:id]
    if @context.update_attributes(params[:context])
      redirect_to tasks_path, :notice => 'Context was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @context = current_user.contexts.find params[:id]
    @context.destroy
    redirect_to tasks_path
  end
end