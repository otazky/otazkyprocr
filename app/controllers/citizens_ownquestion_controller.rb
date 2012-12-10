# OwnQuestion is formulated by a citizen (only 1)
# 3 most popular of these questions may compete with the official candidates´ strategic questions

class OwnQuestionController < ApplicationController 
before_filter: get_ownquestion, :only => [:show, :destroy, :index]

	def get_ownquestion
	   @oq = OwnQuestion.find(params[:id])
	   if @citizen.ownquestion==0
           redirect_to ()
           end
	end

        def new

	end

	def create
	  @oq= OwnQuestion.create(:status => params[:status] )
	end

	def index
		@oq_all=OwnQuestion.all
	end

	def show
		render :action => 'status'
	end 

	def destroy
		if session[:citizen_id] !=@ownquestion.citizen_id
		flash[:notice] = "Opravdu chcete otázku smazat? Všechny dosud získané body od ostatních voličů se tím pádem vynulují."
		@og.destroy
	end
	
end