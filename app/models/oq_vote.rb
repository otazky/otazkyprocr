class OqVote < ActiveRecord::Base
  attr_accessible :own_question_id, :user_id      , :value
end
