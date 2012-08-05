class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def current_user
      if session[:user_type] == 'Refinery::Citizens::Citizen'
        @current_user ||= Refinery::Citizens::Citizen.find(session[:user_id]) if session[:user_id]
      end

      if session[:user_type] == 'Refinery::Keepers::Keeper'
        @current_user ||= Refinery::Keepers::Keeper.find(session[:user_id]) if session[:user_id]
      end
    end
    helper_method :current_user
end