# encoding: UTF-8

class TasksController < ApplicationController

  before_filter :authorized_citizen_access?

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


  def for_approval
    @task = Task.find(params[:id])
    @task.update_attribute(:state, Taks::FOR_APPROVAL)
    respond_to do |format|
        @citizen = Refinery::Citizens::Citizen.find(params[:citizen_id])
        @question = @task.question
        format.html {render 'citizens_tasks/tasks', layout:false}
    end

  end

  def set_as_done
    @task = Task.find(params[:id])
    @task.update_attribute(:state, Taks::DONE )
    respond_to do |format|
      @citizen = Refinery::Citizens::Citizen.find(params[:citizen_id])
      @question = @task.question
      format.html {render 'citizens_tasks/tasks', layout:false}
    end
  end

end

