# encoding: utf-8

class OwnQuestionsController < ApplicationController

  layout false
  before_filter :authorized_citizen_access?

  def create
    @own_question=Refinery::OwnQuestions::OwnQuestion.new(params[:own_question])
    @own_question.citizen=current_user
    if @own_question.save
      render 'create'
    else
      render "errors"
    end


  end

  def destroy
    @oq = Refinery::OwnQuestions::OwnQuestion.find(params[:id])
    @oq.update_attribute(:deleted_at, Time.now)

    respond_to do |format|
      format.html { render partial:'show' }
      format.json { head :no_content }
    end
  end

end
