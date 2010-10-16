class ProjectsController < ApplicationController
  
  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find params[:id]
  end

  def create
    @project = current_user.projects.new params[:project]
    if @project.save
      redirect_to tasks_path, :notice => 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = current_user.projects.find params[:id]
    if @project.update_attributes(params[:project])
      redirect_to tasks_path, :notice => 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find params[:id]
    @project.destroy
    redirect_to tasks_path
  end
end