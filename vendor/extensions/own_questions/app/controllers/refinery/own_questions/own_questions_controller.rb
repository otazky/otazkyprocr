module Refinery
  module OwnQuestions
    class OwnQuestionsController < ::ApplicationController

      before_filter :find_all_own_questions
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @own_question in the line below:
        present(@page)
      end

      def show
        @own_question = OwnQuestion.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @own_question in the line below:
        present(@page)
      end

    protected

      def find_all_own_questions
        @own_questions = OwnQuestion.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/own_questions").first
      end

    end
  end
end
