# encoding: UTF-8

class QuestionsController < ApplicationController
  skip_filter :block_citizen_without_question

  def index
    @questions = Refinery::Questions::Question.order(:created_at).active
  end

  def show
    # @keeper = Refinery::Keepers::Keeper.find(params[:keeper_id])
    # @subject = Subject.find(params[:politician_id])    
    @question = Refinery::Questions::Question.find(params[:id])
  end

  def new
    @keeper = Refinery::Keepers::Keeper.find(params[:keeper_id])
    if params[:politician_id]
      @subject = Subject.find(params[:politician_id])
    end
    if params[:party_id]
      @subject = Subject.find(params[:party_id])
    end
    @question = Refinery::Questions::Question.new
  end

  def create
    @keeper = Refinery::Keepers::Keeper.find(params[:keeper_id])
    @subject = Subject.find(params[:politician_id])
    @election = @subject.elections.last
    @question = Refinery::Questions::Question.new(params[:question])    

    @question.election_id = @election.id
    @question.subject_id = @subject.id

    if @question.save
      redirect_to keeper_path(@keeper), :notice => 'Otázka byla přidána'
    else
      render 'new'
    end
  end

  def edit    
  end  
end
