class TasksController < ApplicationController
  def index
    @new_task = current_user.tasks.new
    @projects = current_user.projects
    @contexts = current_user.contexts
    if params[:project_id]
      tasks = current_user.tasks.where(:project_id => params[:project_id])
    elsif params[:context_id]
      tasks = current_user.tasks.where(:context_id => params[:context_id])
    else
      tasks = current_user.tasks
    end
    @overdue = tasks.overdue
    @today = tasks.today
    @tomorrow = tasks.tomorrow
    @later = tasks.later
    @someday = tasks.someday
  end

  def edit
    @task = current_user.tasks.find params[:id]
    @projects = current_user.projects
    @contexts = current_user.contexts
  end

  def create
    @task = current_user.tasks.new params[:task]
    @projects = current_user.projects
    @contexts = current_user.contexts
    if @task.save
      redirect_to tasks_path, :notice => 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task = current_user.tasks.find params[:id]
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, :notice => 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find params[:id]
    @task.destroy
    redirect_to tasks_path
  end
end