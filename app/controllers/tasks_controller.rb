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
    @projects = current_user.projects
    @contexts = current_user.contexts
    @task = current_user.tasks.find params[:id]
  end

  def create
    @projects = current_user.projects
    @contexts = current_user.contexts
    @task = current_user.tasks.new params[:task]
    
    if params[:task][:name].include?('>')
      project = params[:task][:name].split('>').last.strip.split(' ').first
      @task.project = current_user.projects.find_or_create_by_name(project)
      @task.name.gsub! ">", ''
      @task.name.gsub! project, ''
    end
    
    if params[:task][:name].include?('@')
      context = params[:task][:name].split('@').last.strip.split(' ').first
      @task.context = current_user.contexts.find_or_create_by_name(context)
      @task.name.gsub! "@", ''
      @task.name.gsub! context, ''
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
end