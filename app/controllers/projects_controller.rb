class ProjectsController < ApplicationController

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    @projects = current_user.projects
    @project = current_user.projects.new(params[:project])
    respond_to do |format|
      if @project.save
        format.html { redirect_to tasks_path, :notice => 'Project was successfully created.' }
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  def update
    @projects = current_user.projects
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to tasks_path, :notice => 'Project was successfully updated.' }
        format.js
      else
        format.html { render :action => "edit" }
        format.js
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