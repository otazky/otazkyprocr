# encoding: UTF-8

class CitizensTasksController < ApplicationController

  layout false

  # GET /citizens_tasks
  # GET /citizens_tasks.json
  def index
    @citizens_tasks = CitizensTask.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @citizens_tasks }
    end
  end

  # GET /citizens_tasks/1
  # GET /citizens_tasks/1.json
  def show
    @citizens_task = CitizensTask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @citizens_task }
    end
  end

  # GET /citizens_tasks/new
  # GET /citizens_tasks/new.json
  def accept_wchange
    @citizens_task = CitizensTask.new
    @citizens_task.task= Task.find(params[:task_id])
    @citizens_task.citizen_id=params[:citizen_id]
    @citizens_task.hours=  @citizens_task.task.hours
    render 'new'
  end

  def create
    @citizens_task = CitizensTask.new(params[:citizens_task])
    @subtask=Subtask.new(params[:subtask])
    @subtask.task_id=@citizens_task.task_id
    @subtask.citizen=current_user
    if @subtask.save
      @citizen = current_user
      @question=@citizens_task.task.question
      render json:{ html:render_to_string('citizens_tasks/tasks'), status:'ok'}
    else
      render json:{ html:render_to_string( :partial=>'subtasks/errors'), status:'nok'}
    end
  end

  def accept_task
    @citizens_task = CitizensTask.new
    @citizens_task.task= Task.find(params[:task_id])
    @citizens_task.citizen_id=params[:citizen_id]
    @citizens_task.hours=  @citizens_task.task.hours
    @citizens_task.save

    @question=@citizens_task.task.question
    @citizen= Refinery::Citizens::Citizen.find(@citizens_task.citizen_id )
    render 'tasks'
  end




end
