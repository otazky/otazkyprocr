# encoding: UTF-8

class StatsController < ApplicationController
  def index
    @stats = Stat.new
    @politicians = Refinery::Politicians::Politician.active
  end

  def politician
      @stat = Stat::Politician.new(Refinery::Politicians::Politician.find(params[:id]))
      render :layout => !request.xhr?
  end
end
