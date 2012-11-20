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

    task=Task.find(params[:task_id])

    @citizens_task.hours=  task.hours
    if params[:change]

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @citizens_task }
      end
    else
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

    respond_to do |format|
      if @citizens_task.save
        format.html { redirect_to @citizens_task, notice: 'Úkol byl úspěšně přidán.' }
        format.json { render json: @citizens_task, status: :created, location: @citizens_task }
      else
        format.html { render action: "new" }
        format.json { render json: @citizens_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /citizens_tasks/1
  # PUT /citizens_tasks/1.json
  def update
    @citizens_task = CitizensTask.find(params[:id])

    respond_to do |format|
      if @citizens_task.update_attributes(params[:citizens_task])
        format.html { redirect_to @citizens_task, notice: 'Úkol byl úspěšně upraven.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @citizens_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /citizens_tasks/1
  # DELETE /citizens_tasks/1.json
  def destroy
    @citizens_task = CitizensTask.find(params[:id])
    @citizens_task.destroy

    respond_to do |format|
      format.html { redirect_to citizens_tasks_url }
      format.json { head :no_content }
    end
  end
end
