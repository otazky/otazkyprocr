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


      def averege_hours_done
        n=CitizensQuestion.where(question_id: id).count
        if n>0
          hours_done_sum / n
        else
          0
        end
      end


      def hours_done_sum
        CitizensQuestion.where(question_id: id).sum('hours_done')

      end


      def hours_sum(minimal_hours)
        CitizensQuestion.where(question_id: id, citizen_id: self.citizens.where("hours>#{minimal_hours}")).sum('hours')
      end

      # buď  100 lidí v týmu a celkem 100 hodin a každý volič/ka aspoň 1 hodina
      # anebo   50 lidí a 150 hodin celkem a každý volič/ka aspoň 2 hodiny a časový práh!!!!
      # nebo    25 lidí a 200 hodin celkem a každý volič/ka aspoň 5 hodin a časový práh!!!!
      # nebo     20 lidí a 300 hodin celkem a každý volič/ka aspoň 10 hodin a časový práh!!!!

      def citizens_with_hours(hours)
            CitizensQuestion.where("question_id=#{id} AND hours>#{hours}").count
      end
      def needed

        c=   citizens_with_hours 1

        if c<100
          need_c=100-c
          need_h=100-hours_sum(1)
        end
        c=   citizens_with_hours 2
        if c<50
          need_c=50-c
          need_h=150-hours_sum(2)
        end

        c=   citizens_with_hours 5
        if c<25
          need_c=25-c
          need_h=200-hours_sum(5)
        end
        c=   citizens_with_hours 10
        if c<20
          need_c=20-c
          need_h=300-hours_sum(10)
        end

        return [need_c, need_h]
      end

      def subject_name
        if subject.subtype == 'Refinery::Politicians::Politician'
          name = "#{subject.firstname} #{subject.lastname}"
        else
          name = subject.name
        end
        name
      end


    end
  end
end
