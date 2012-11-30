# encoding: UTF-8

class StatsController < ApplicationController
  def index
    @stats = Stat.new
    @politicians = Refinery::Politicians::Politician.active.order(:lastname, :firstname)
    Stat.compute_oph
  end

  def politician
      @stat = Stat::Politician.new(Refinery::Politicians::Politician.find(params[:id]))
      render :layout => !request.xhr?
  end


  def oph
    @questions=Refinery::Questions::Question.where("NOT disabled").order("cache_oph desc")

  end
end
