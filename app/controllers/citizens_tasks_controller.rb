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
  def new
    @citizens_task = CitizensTask.new
    @citizens_task.task= Task.find(params[:task_id])
    @citizens_task.citizen_id=params[:citizen_id]
    @citizens_task.hours=  @citizens_task.task.hours
    if params[:change]

      respond_to do |format|
        format.html # new.html.erb
      end
    else
      @citizens_task.save
      render 'accepted'
    end

  end


  # GET /citizens_tasks/1/edit
  def edit
    @citizens_task = CitizensTask.find(params[:id])
  end

  # POST /citizens_tasks
  # POST /citizens_tasks.json
  def create
    @citizens_task = CitizensTask.new(params[:citizens_task])


    if params[:subtask][:body]
      subtask=Subtask.new(:content=>params[:subtask][:body], :task_id=>@citizens_task.task_id)
      subtask.save
    end


    respond_to do |format|
      if @citizens_task.save
        @question=@citizens_task.task.question
        @citizen= Refinery::Citizens::Citizen.find( @citizens_task.citizen_id )



        format.html {render :action=>'tasks'}
        #format.json { render json: @citizens_task, status: :created, location: @citizens_task }
      else
        #format.html { render action: "new" }
        format.json { render layout:false, json: @citizens_task.errors, status: :unprocessable_entity }
      end
    end
  end

end
