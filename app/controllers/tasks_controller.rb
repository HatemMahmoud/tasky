class TasksController < ApplicationController
  before_filter :find_projects_and_contexts, :only => [:index, :new, :edit, :create, :update]
  
  def index
    @new_task = current_user.tasks.new
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
  
  def new
    @task = current_user.tasks.new
  end

  def edit
    @task = current_user.tasks.find params[:id]
  end

  def create
    @task = current_user.tasks.new params[:task]
    
    case params[:task][:due_at].downcase
    when 'today', 'tod'
      @task.due_at = Date.today.midnight
    when 'tomorrow', 'tom'
      @task.due_at = Date.tomorrow.midnight
    end
    
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
  
  private
  
  def find_projects_and_contexts
    @projects = current_user.projects.order('name')
    @contexts = current_user.contexts.order('name')
  end
end