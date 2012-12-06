# encoding: UTF-8

class CitizensQuestionsController < ApplicationController
  def new
    if !current_user
      session[:return_url] = request.fullpath
      redirect_to main_app.new_session_path, notice: 'Pro řešení otázky musíte být přihlášen(a).'
    else
      @question = Refinery::Questions::Question.find(params[:question_id])
      @cq=CitizensQuestion.where(citizen_id: current_user.id, question_id: @question.id).where("hours>0").first
      @citizens_question = CitizensQuestion.new(citizen_id: current_user.id, question_id: @question.id)

    end      
  end

  def create    
    @citizens_question = CitizensQuestion.new(params[:citizens_question])
    @question = Refinery::Questions::Question.find(@citizens_question.question_id)
  
    if @citizens_question.valid?
      if @citizens_question.hours <= 3
        @citizens_question.save
        CitizensMailer.question_info(current_user, @question).deliver
        redirect_to '/', flash: { notice: 'Skvělé! Ve Správě účtu najdete nyní jméno jednoho z týmových spolupracovníků a první úkoly k vypracování. Z nich si můžete vybrat. Pokud jste si ovšem danou otázku vybral(a) jako první, je na Vás, abyste vymyslel(a) první úkoly pro tým sám(a). Pusťte se do toho. Budeme Vám držet palce.' }
      else
        session[:c_q_question_id] = @citizens_question.question_id
        session[:c_q_citizen_id]  = current_user.id
        session[:c_q_hours]       = @citizens_question.hours
        redirect_to @citizens_question.paypal_url
      end
    else
      render 'new'
    end

"""
    if @citizens_question.save
      redirect_to main_app.citizen_path(current_user.id), notice: 'Otázka byla přidána do Vašeho účtu' 
    else
      render 'new'
    end
"""
  end

  def edit    
    @citizens_question = CitizensQuestion.find(params[:id])
  end

  def update
    @citizens_question = CitizensQuestion.find(params[:id])
    @citizens_question.hours += params[:citizens_question][:hours].to_i

    if @citizens_question.save
      redirect_to citizen_path(@citizens_question.citizen_id), notice: 'Počet hodin byl upraven.' 
    else
      render 'edit'
    end
  end

  def move
    model_for_move
  end

  def relocate_hours
    model_for_move

    @new_citizens_question = CitizensQuestion.find_or_initialize_by_citizen_id_and_question_id(
      params[:citizen_id], 
      params[:citizens_question][:question_id]
    )

    hours = params[:citizens_question][:hours].to_i
    @current_citizens_question.hours = @current_citizens_question.hours.to_i - hours
    @new_citizens_question.hours     = @new_citizens_question.hours.to_i     + hours
    @current_citizens_question.hours_moved += hours

    begin
      CitizensQuestion.transaction do 
          @current_citizens_question.save!
          @new_citizens_question.save!
      end
      redirect_to citizen_path(@new_citizens_question.citizen_id), notice: 'Hodiny byly přeneseny.' 
    rescue ActiveRecord::RecordInvalid
      @current_citizens_question.reload # original #hours on error
      render 'move'
    end
  end

  def payment

  end

  protected

  def model_for_move
    @current_citizens_question = CitizensQuestion.find(params[:id])
    @current_question = Refinery::Questions::Question.find(@current_citizens_question.question_id)
    @new_citizens_question = CitizensQuestion.new    
  end
end
