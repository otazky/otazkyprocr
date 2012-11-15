# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  keeper_id  :integer          not null
#  subtype    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ActiveRecord::Base
  acts_as_superclass
  attr_accessible :keeper_id, :subtype

  belongs_to :keeper, :class_name => 'Refinery::Keepers::Keeper'
  has_many :election_subject_elections
  has_many :elections, :through => :election_subject_elections
  has_many :questions, :class_name => 'Refinery::Questions::Question'

  def citizens_questions
      CitizensQuestion.joins(question: :subject).where(subjects: {id: id})
  end

  def citizens
      Refinery::Citizens::Citizen.uniq.joins(questions: :subject).where(subjects: {id: id})
  end

  def counties
      Refinery::Counties::County.uniq.joins(citizens: {questions: :subject}).where(subjects: {id: id})
  end
end
