class Subtask < ActiveRecord::Base

  belongs_to :task
  attr_accessible :content  , :task_id
end
