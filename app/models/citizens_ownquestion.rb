# Each citizen may formulate just one own question


class OwnQuestion < ActiveRecord::Base

  belongs_to :citizen , :class_name=>'Refinery::Citizens::Citizen'
  attr_accessible :content , :citizen_id, :own_question_id, :votes 

end