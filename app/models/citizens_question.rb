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
  validates :hours, numericality: { only_integer: true, greater_than: 0 }, on: :create
  validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
  validate :allowed_time_before_elections

  def hours_remaining
      h = hours.to_i - hours_done
      h < 0 ? 0 : h
  end

  before_save(on: :create) do
    citizens_question = CitizensQuestion.where("question_id=#{self.question_id} AND citizen_id>0").shuffle
    if citizens_question.any?
      partner_c = citizens_question.first.citizen
      if  partner_c && self.citizen_id &&  self.citizen
        self.partner = partner_c.id == self.citizen.id ? citizens_question.last.citizen : partner_c
      end
    end
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
    if allowed_hours < hours
      errors.add(:hours, "K dispozici je maximálně #{allowed_hours} hodin.")
    end
  end

  def allowed_hours
    held = question.election.held
    to_election = held - Date.today
    if to_election <= 0
      0
    elsif to_election == 1
      [((held.to_time - Time.now) / 1.hour).to_i, 4].min
    else
      (to_election * 4).to_i
    end
  end

  def teamleader_id
    if self.teamleader == 1
      self.citizen_id
    else
      nil
    end
  end

  def available_hours
    h=CitizensTask.where("citizen_id=#{citizen_id} AND task_id IN (SELECT id from tasks WHERE question_id=#{question_id})").sum(:hours)
    hours_subtask = Subtask.where("citizen_id=#{citizen_id} AND task_id IN (SELECT id from tasks WHERE question_id=#{question_id})").sum(:hours)
    hours - h - hours_subtask
  end

end
