class ElectionsController < ApplicationController
  def show
    @election = Refinery::Elections::Election.find(params[:id])

    @parties = Refinery::Parties::Party.joins(subject: :elections)
      .where(refinery_elections: { id: @election.id }).order(:name)

    @politicians = Refinery::Politicians::Politician.joins(subject: :elections)
      .where(refinery_elections: { id: @election.id }).order(:lastname, :firstname)


		@own_questions = Refinery::OwnQuestions::OwnQuestion.order("score desc, id") if @election.election_type_id==4
		@own_questions = Refinery::OwnQuestions::OwnQuestion.where('d50').order("score desc, id") if @election.election_type_id==5
  end
end
