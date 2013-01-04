module Refinery
  module OwnQuestions
    class OwnQuestion < Refinery::Core::BaseModel
      self.table_name = 'refinery_own_questions'

      attr_accessible :content, :title, :position , :d50

      acts_as_indexed :fields => [:content, :title]

      validates :content, :presence => true, :uniqueness => true

      belongs_to :citizen , :class_name=>'Refinery::Citizens::Citizen'


      default_scope :conditions => 'deleted_at IS NULL'


      def voted_by(user)
        OqVote.where(:own_question_id=>id, :user_id => user.id).any?
      end

    end
  end
end
