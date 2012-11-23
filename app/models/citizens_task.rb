class CitizensTask < ActiveRecord::Base
  belongs_to :citizen  , :class_name=>'Refinery::Citizens::Citizen'
  belongs_to :task
  attr_accessible :hours, :task_id, :citizen_id

  validates_numericality_of :hours,  :allow_nil => false,  :greater_than_or_equal_to => 0.5
end
