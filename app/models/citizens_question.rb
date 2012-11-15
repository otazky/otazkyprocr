# encoding: UTF-8

# == Schema Information
#
# Table name: citizens_questions
#
#  id          :integer          not null, primary key
#  citizen_id  :integer
#  question_id :integer
#  hours       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hours_done  :integer          default(0)
#

class CitizensQuestion < ActiveRecord::Base
  attr_accessible :citizen_id, :hours, :hours_done, :hours_moved, :question_id, :teamleader
  belongs_to :citizen, :class_name => 'Refinery::Citizens::Citizen'
  belongs_to :question, :class_name => 'Refinery::Questions::Question'
  belongs_to :partner, :class_name => 'Refinery::Citizens::Citizen'

  scope :active, joins(question: :election).where(refinery_elections: {done: false})

  # validate :no_more_promised_hours, on: :update
  validates :hours, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 200, message: 'Zadejte prosím celé číslo v rozmezí 1 - 200' }, on: :create
  validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
  validate :allowed_time_before_elections

  def hours_remaining
      h = hours.to_i - hours_done
      h < 0 ? 0 : h
  end

  before_save(on: :create) do
    citizens_question = CitizensQuestion.where('question_id = ?', self.question_id).shuffle
    citizen = Refinery::Citizens::Citizen.find(citizens_question.first.citizen_id)
    if citizens_question.first.citizen_id == citizen.id
      citizens_question = citizens_question.last
      citizen = Refinery::Citizens::Citizen.find(citizens_question.citizen_id)
    end
    self.partner = citizen
  end

  def paypal_url
    values = {
      :business => '&rsquo;seller_1234111143_biz@asciicasts.com&rsquo;',
      :cmd => '&rsquo;_cart&rsquo;',
      :upload => 1,      
      :invoice => id,
      :amount => 5,
      :item_name => Rack::Utils.escape('Počet hodin'),
      :item_quantity => self.hours
    }      
   
    if self.hours > 3
      case self.hours
        when 4
          values[:amount] = 12.50
        when 5
          values[:amount] = 10
        when 6
          values[:amount] = 8.50
        when 7
          values[:amount] = 7.50
        when 8
          values[:amount] = 6.50
        when 9
          values[:amount] = 6.00
        else
          values[:amount] = 5.00
      end
    end

    "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=ceskaprezidentka@seznam.cz&item_name=#{values[:item_name]}&amount=#{values[:amount]}&quantity=#{values[:item_quantity]}&currency_code=CZK&return_url=http://otazkyprocr.cz/payments/paypal/"
  end

  def no_more_promised_hours
    hours_old = CitizensQuestion.find(id).hours

    if hours_old > hours_done
      errors.add(:hours, "zůstává Vám ješte #{hours - hours_done} přislíbených hodin.")
    end
  end

  def allowed_time_before_elections
    question = Refinery::Questions::Question.find(question_id)
    election = question.election
    time_to_election = (election.held.to_time - Time.now().to_time) / 60 / 60 / 24
    allowed_hours = (time_to_election * 4).round

    if allowed_hours < hours
      errors.add(:hours, "pro danou otázku je k dispozici maximálně #{allowed_hours} hodin.")
    end
  end

  def teamleader_id
    if self.teamleader == 1
      self.citizen_id
    else
      nil
    end
  end
end
