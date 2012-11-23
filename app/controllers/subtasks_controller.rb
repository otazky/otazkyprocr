# encoding: UTF-8

class SubtasksController < ApplicationController

  before_filter :authorized_citizen_access?
  layout:false

   def new
    @subtask = Subtask.new
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subtask }
    end
  end

  def edit
    @subtask = Subtask.find(params[:id])
  end

  def create
    @subtask = Subtask.new(params[:subtask])
    @subtask.task_id=params[:task_id]

    if @subtask.save
      @citizen = current_user
      @question = @subtask.task.question
      render json:{ html:render_to_string('citizens_tasks/tasks'), status:'ok'}
    else
      render json:{ html:render_to_string( :partial=>'errors'), status:'nok'}
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

  def accept
    @subtask = Subtask.find(params[:id])
    @subtask.update_attribute(:citizen, current_user)
    @citizen = current_user
    @question = @subtask.task.question
    render 'citizens_tasks/tasks'
  end

  def accept_step2
    @subtask = Subtask.find(params[:id])
    @subtask.citizen_id=current_user.id
    @subtask.hours=params[:subtask][:hours]

    if @subtask.save
      @citizen = current_user
      @question = @subtask.task.question
      render json:{ html:render_to_string('citizens_tasks/tasks'), status:'ok'}
    else
      render json:{ html:render_to_string( :partial=>'errors'), status:'nok'}
    end
  end


  def edit_done
    @subtask = Subtask.find(params[:id])
  end


  def done
    @subtask = Subtask.find(params[:id])
    h=params[:subtask][:hours]
    if @subtask.hours>=h.to_i
      @subtask.hours=h
      @subtask.state= Task::FOR_APPROVAL
    else
      @err="Nová časová dotace nesmí být větší než původní"
    end

    if !@err && @subtask.save
      @citizen = current_user
      @question = @subtask.task.question
      render json:{ html:render_to_string('citizens_tasks/tasks'), status:'ok'}
    else
      render json:{ html:render_to_string( :partial=>'errors'), status:'nok'}
    end
  end

  def verify
    @subtask = Subtask.find(params[:id])
    @citizen = current_user
    @question = @subtask.task.question

    if @question.is_teamleader?(@citizen)
      @subtask.hours_done=@subtask.hours
      @subtask.state=Task::DONE
      @subtask.save
    end
    render 'citizens_tasks/tasks'
  end
end
