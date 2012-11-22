class CitizensTask < ActiveRecord::Base
  belongs_to :citizen  , :class_name=>'Refinery::Citizens::Citizen'
  belongs_to :task
  attr_accessible :hours, :task_id, :citizen_id
end
