class CitizensTask < ActiveRecord::Base
  attr_accessible :hours, :task_id, :citizen_id
  belongs_to :citizen
  belongs_to :task
end
