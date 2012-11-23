# encoding: UTF-8

class TasksController < ApplicationController

  before_filter :authorized_citizen_access?

  layout false ,:only=>['for_approval','for_approval_new', :verify]

  def index
  end

  def new
    @task = Task.new
  end


  def edit
     @task = Task.find(params[:id])

  end


  def update

    @task = Task.find(params[:id])
    if @task.update_attributes params[:task]
      redirect_to main_app.citizen_path(params[:citizen_id]), flash: { success:'Úkol byl upraven.' }
    else
      render 'edit'
    end

  end

  def create
    @task = Task.new(params[:task])
    @task.question_id = params[:question_id]
    if @task.save
      redirect_to main_app.citizen_path(params[:citizen_id]), flash: { success: 'Úkol byl přidán.' }
    else
      render 'new'
    end    
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to main_app.citizen_path(params[:citizen_id]), flash: { success: 'Úkol byl smazán.' }
  end


  def for_approval_new
    @task = Task.find(params[:id])
    render 'for_approval'
  end

  def for_approval
    @task = Task.find(params[:id])
    @task.state= Task::FOR_APPROVAL
    @citizens_task=CitizensTask.where(task_id: @task.id, citizen_id: current_user.id).first
    h=params[:task][:hours]
    if @task.hours>=h.to_i
      @citizens_task.hours=h
      @task.state= Task::FOR_APPROVAL
    else
      @err="Nová časová dotace nesmí být větší než původní"
    end

    if !@err && @task.save && @citizens_task.save
      @citizen = Refinery::Citizens::Citizen.find(params[:citizen_id])
      @question = @task.question
      render json:{ html:render_to_string('citizens_tasks/tasks'), status:'ok'}
    else
      render json:{ html:render_to_string( :partial=>'errors'), status:'nok'}
    end

  end

  def verify
    @task = Task.find(params[:id])
    @task.update_attribute(:state, Task::DONE )

    respond_to do |format|
      @citizen = Refinery::Citizens::Citizen.find(params[:citizen_id])
      @question = @task.question
      format.html {render 'citizens_tasks/tasks', layout:false}
    end
  end

end

