class ProjectsController < ApplicationController

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.new(params[:project])
    respond_to do |format|
      if @project.save
        format.html { redirect_to tasks_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to tasks_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
    end
  end
end