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

  def vote

    oq= Refinery::OwnQuestions::OwnQuestion.find(params[:own_question_id])
    val=params[:value].to_i

    vote=OqVote.where(:own_question_id=>oq.id, :user_id => current_user.id).first
    if !vote
      OqVote.create!(:own_question_id=>oq.id, :user_id => current_user.id, :value=>val)
      oq.score = OqVote.where(:own_question_id=>oq.id).sum(:value)
      oq.save
    end
    respond_to do |format|
      format.html { render partial:'ownquestions_voting' }
    end
  end

  def remove_vote
    vote=OqVote.where(:own_question_id=>params[:own_question_id], :user_id => current_user.id).first
    vote.destroy
    oq= Refinery::OwnQuestions::OwnQuestion.find(params[:own_question_id])
    oq.score = OqVote.where(:own_question_id=>oq.id).sum(:value)
    oq.save
    respond_to do |format|
      format.html { render partial:'ownquestions_voting' }
    end
  end


end
