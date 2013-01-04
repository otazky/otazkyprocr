class OqVote < ActiveRecord::Base
  attr_accessible :own_question_id, :user_id      , :value
  belongs_to :citizen  , :class_name=>'Refinery::Citizens::Citizen'
  belongs_to :own_question , :class_name=>'Refinery::OwnQuestions::OwnQuestion'
end
