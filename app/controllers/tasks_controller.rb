class TasksController < ApplicationController
  def index
    @new_task = current_user.tasks.new
    tasks = current_user.tasks
    @overdue = tasks.overdue
    @today = tasks.today
    @tomorrow = tasks.tomorrow
    @later = tasks.later
    @someday = tasks.someday
    @done = tasks.done
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
    @task = current_user.tasks.where(params[:id])
  end

  def create
    @task = current_user.tasks.new(params[:task])
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, :notice => 'Task was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @task = current_user.tasks.where(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path, :notice => 'Task was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @task = current_user.tasks.where(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
    end
  end
end