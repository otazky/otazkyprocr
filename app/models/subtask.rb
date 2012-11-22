class Subtask < ActiveRecord::Base

  belongs_to :task
  belongs_to :citizen  , :class_name=>'Refinery::Citizens::Citizen'
  attr_accessible :content  , :task_id , :hours

  validates_numericality_of :hours,  :allow_nil => false,  :greater_than_or_equal_to => 0.5

end
