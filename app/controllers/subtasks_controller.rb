class SubtasksController < ApplicationController
  # GET /subtasks
  # GET /subtasks.json
  def index
    @subtasks = Subtask.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subtasks }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def show
    @subtask = Subtask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/new
  # GET /subtasks/new.json
  def new
    @subtask = Subtask.new
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1/edit
  def edit
    @subtask = Subtask.find(params[:id])
  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    @subtask = Subtask.new(params[:subtask])
    @subtask.task_id=params[:task_id]

    respond_to do |format|
      if @subtask.save
        format.html { redirect_to main_app.citizen_path(params[:citizen_id]), notice: 'Podúkol byl úspěšně vytvořen.' }
        format.json { render json: @subtask, status: :created, location: @subtask }
      else
        format.html { render action: "new" }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subtasks/1
  # PUT /subtasks/1.json
  def update
    @subtask = Subtask.find(params[:id])

    respond_to do |format|
      if @subtask.update_attributes(params[:subtask])
        format.html { redirect_to main_app.citizen_path(params[:citizen_id]), notice: 'Podúkol byl úspěšně změněn.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    @subtask = Subtask.find(params[:id])
    @subtask.destroy

    respond_to do |format|
      format.html { redirect_to main_app.citizen_path(params[:citizen_id]) }
      format.json { head :no_content }
    end
  end
end
