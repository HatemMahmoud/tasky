class TasksController < ApplicationController
  before_filter :find_tasks, :only => [:index, :new, :create, :edit, :update]
  before_filter :edit_due_at, :only => [:create, :update]
  
  def index
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
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path, :notice => 'Task was successfully updated.' }
        format.js
      else
        format.html { render :action => "edit" }
        format.js
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
  
  def find_tasks
    @task = current_user.tasks.new
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
    @done = tasks.done
    @project = current_user.projects.new
    @projects = current_user.projects
    @context = current_user.contexts.new
    @contexts = current_user.contexts
  end
  
  def edit_due_at
    if params[:task][:due_at]
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
  end
    
  def advance(wday)
    current_wday = Date.current.wday
    (wday - current_wday) > 0 ? (wday - current_wday) : (wday - current_wday + 8)
  end
end