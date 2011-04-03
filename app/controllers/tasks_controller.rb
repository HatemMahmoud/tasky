class TasksController < ApplicationController
  before_filter :edit_due_at, :only => [:create, :update]
  
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
    @task = current_user.tasks.find(params[:id])
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
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path, :notice => 'Task was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
    end
  end
  
  def edit_due_at     
    due_at = params[:task][:due_at].capitalize
    case due_at
    when 'Today', 'Tod'
      params[:task][:due_at] = Date.current.midnight
    when 'Tomorrow', 'Tom'
      params[:task][:due_at] = Date.tomorrow.midnight
    when "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
      task_wday = Date::DAYNAMES.index(due_at)
      params[:task][:due_at] = Date.current.advance(:days => advance(task_wday))
    when "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
      task_wday = Date::ABBR_DAYNAMES.index(due_at)
      params[:task][:due_at] = Date.current.advance(:days => advance(task_wday))
    end
  end
    
  def advance(wday)
    current_wday = Date.current.wday
    (wday - current_wday) > 0 ? (wday - current_wday) : (wday - current_wday + 8)
  end
end