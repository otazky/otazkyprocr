module Refinery
  module OwnQuestions
    module Admin
      class OwnQuestionsController < ::Refinery::AdminController

        crudify :'refinery/own_questions/own_question', :xhr_paging => true

      end
    end
  end
end
