# encoding: UTF-8

module Refinery
  module Questions
    class Question < Refinery::Core::BaseModel
      self.table_name = 'refinery_questions'
      belongs_to :election, class_name: 'Refinery::Elections::Election'
      belongs_to :subject
      has_many :citizens_questions, class_name: 'CitizensQuestion'
      has_many :citizens, through: :citizens_questions
      has_many :tasks, class_name: 'Task'

      attr_accessible :title, :content, :election_id, :subject_id, :position, :done, :disabled

      acts_as_indexed :fields => [:title, :content]

      validate :permited_question_count, on: :create
      validates :title, :presence => true, :uniqueness => true      

      scope :enabled, where(disabled: false)
      scope :active, enabled.joins(:election).where(refinery_elections: {done: false})

      def counties
        Refinery::Counties::County.uniq.joins(citizens: :questions).where(refinery_questions: {id: id})
      end

      def permited_question_count
        if (self.election.election_type.name == 'Prezidentské volby' && get_questions_count_for_subject(self.subject_id) >= 2) || (self.election.election_type.name != 'Prezidentské volby' && get_questions_count_for_subject(self.subject_id) >= 1) 
            errors.add(:count, 'dosáhli ste maximálni počet otázek pro Váš účet.')
        end
      end

      def get_questions_count_for_subject(subject_id)
        Question.where("subject_id = ? and disabled = ?", subject_id, false).count('id')
      end

      def teamleader
          citizens_question = citizens_questions.where(teamleader: 1).order('hours DESC').first
          citizens_question ? citizens_question.citizen : nil
      end

      def is_teamleader?(citizen)
          cq = citizens_questions.to_a
          (cq.size == 1 && cq.first.citizen_id == citizen.id) or citizen == teamleader
      end
    end
  end
end
