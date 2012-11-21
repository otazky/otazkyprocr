class CitizensTask < ActiveRecord::Base
  attr_accessible :hours
  belongs_to :citizen
  belongs_to :question
end
