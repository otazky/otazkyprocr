module OwnQuestionsHelper
  def own_questions
    Refinery::OwnQuestions::OwnQuestion.order("score desc, id")
  end
end
