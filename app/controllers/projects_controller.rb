class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects.all
  end

  def show
    @project = current_user.projects.find params[:id]
  end

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find params[:id]
  end

  def create
    @project = current_user.projects.new params[:project]
    if @project.save
      redirect_to @project, :notice => 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = current_user.projects.find params[:id]
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find params[:id]
    @project.destroy
    redirect_to projects_path
  end
end