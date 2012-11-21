class ElectionsController < ApplicationController
  def show
    @election = Refinery::Elections::Election.find(params[:id])

    @parties = Refinery::Parties::Party.joins(subject: :elections)
      .where(refinery_elections: { id: @election.id }).order(:name)

    @politicians = Refinery::Politicians::Politician.joins(subject: :elections)
      .where(refinery_elections: { id: @election.id }).order(:lastname, :firstname)
  end
end
