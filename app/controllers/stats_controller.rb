# encoding: UTF-8

class StatsController < ApplicationController
  def index
    @stats = Stat.new
    @politics = Refinery::Politicians::Politician.active if params[:show_politicians]
  end
end
