class TasksController < ApplicationController
  def index
    @overdue = current_user.tasks.overdue
    @today = current_user.tasks.today
    @tomorrow = current_user.tasks.tomorrow
    @later = current_user.tasks.later
    @someday = current_user.tasks.someday
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
    @task = current_user.tasks.find params[:id]
  end

  def create
    @task = current_user.tasks.new params[:task]
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
