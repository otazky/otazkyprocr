module Refinery
  module OwnQuestions
    class OwnQuestion < Refinery::Core::BaseModel
      self.table_name = 'refinery_own_questions'

      attr_accessible :content, :title, :position

      acts_as_indexed :fields => [:content, :title]

      validates :content, :presence => true, :uniqueness => true

      belongs_to :citizen , :class_name=>'Refinery::Citizens::Citizen'

    end
  end
end
