class Task < ActiveRecord::Base
  belongs_to :question, class_name: 'Refinery::Questions::Question'
  attr_accessible :content  , :hours
  has_many :subtasks
  has_one :citizens_task


  DONE         = 3
  FOR_APPROVAL = 2


  def responsible_citizen
    ct=CitizensTask.where(task_id:self.id).first
    ct.citizen if ct
  end

end