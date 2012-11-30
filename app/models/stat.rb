# encoding: UTF-8

class Stat  
  include ActiveModel::Conversion
  extend ActiveModel::Naming  

  class Politician
    attr_reader :politician

    def initialize(politician)
      @politician = politician
    end

    def values
      [
         ["Počet otázek kandidáta",                                   questions.size],
         ["Počet aktivních týmů kandidáta/tky",                       team_count],
         ["Počet aktivních voličů celkem (všechny otázky dohromady)", citizens_count],
         ["Zastoupenost okresů (počet celkem)",                       counties_count],
         ["Počet přislíbených hodin celkem",                          hours_count],
         ["Počet odpracovaných hodin celkem",                         hours_done_count],
         ["Počet odchodů (převodů hodin) k jinému kandidátovi",       hours_moved_count],
      ]
    end

    def citizens_questions
      @citizens_questions ||= @politician.subject.citizens_questions.active.to_a
    end

    def questions
      @questions ||= @politician.questions.active.to_a
    end

    def team_count
      citizens_questions.map {|q| q.question_id }.uniq.size
    end

    def citizens_count
      citizens_questions.map {|q| q.citizen_id }.uniq.size
    end

    def counties_count
      @politician.subject.counties.active.to_a.size # count does not work (used DISTINCT)
    end

    def hours_count
      citizens_questions.reduce(0) {|sum, q| sum + q.hours }
    end

    def hours_done_count
      citizens_questions.reduce(0) {|sum, q| sum + q.hours_done }
    end

    def hours_moved_count
      citizens_questions.reduce(0) {|sum, q| sum + q.hours_moved }
    end

    def questions_stats
      questions.map {|q| Question.new(q) }.sort_by(&:citizens_count).reverse
    end
  end

  class Question
    attr_reader :question

    def initialize(question)
      @question = question
    end

    def values
      [
         ["Počet aktivních voličů",           citizens_count],
         ["Zastoupenost okresů",              counties.size],
         ["Nejaktivnější (1) okres",          most_active_county],
         ["Počet přislíbených hodin celkem",  question.citizens_questions.sum(:hours)],
         ["Počet odpracovaných hodin celkem", question.citizens_questions.sum(:hours_done)],
      ]
    end

    def citizens
      @citizens ||= @question.citizens.to_a
    end

    def counties
      @counties ||= citizens.group_by {|c| c.county_id}
    end
    
    def citizens_count
      citizens.size
    end

    def most_active_county
      counties.empty? ? '-' : counties.values.sort_by {|a| a.size}.last.first.county.name
    end
  end


  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat( vars )
    super
  end

 def self.attributes
   @attributes
 end

 def initialize(attributes={})
   attributes && attributes.each do |name, value|
     send("#{name}=", value) if respond_to? name.to_sym 
   end
 end

  def persisted?
    false
  end

  def self.inspect
    "#<#{ self.to_s} #{ self.attributes.collect{ |e| ":#{ e }" }.join(', ') }>"
  end

  def questions_count
    Refinery::Questions::Question.active.count
  end

  def self.citizens_count
    Refinery::Citizens::Citizen.count
  end

  def politicians_count
    Refinery::Politicians::Politician.count
  end

  def citizens_men_count
    Refinery::Citizens::Citizen.where("gender = 'male'").count
  end

  def citizens_women_count
    Refinery::Citizens::Citizen.where("gender = 'female'").count
  end

  def promised_workhours_sum
    CitizensQuestion.active.sum('hours')
  end

  def done_workhours_sum
    CitizensQuestion.active.sum('hours_done')
  end

  def citizens_average_age
    Refinery::Citizens::Citizen.average('age').round(2)
  end

  def team_count
    CitizensQuestion.active.group(:question_id).count.size
  end

  def questions_without_team_count
    result = Refinery::Questions::Question.active.count - self.team_count.to_i
    if Refinery::Questions::Question.active.count - self.team_count.to_i < 0
      result = 0
    end
    result
  end

  def percent_of_citizens
    (Refinery::Citizens::Citizen.count('id') / (8415892 / 100)).round(5)
  end

  def county_with_most_citizens
    @citizens_count = 0
    Refinery::Counties::County.all.each do |county|      
      if county.citizens.count > @citizens_count
        @county = { citizens_count: county.citizens.count, name: county.name }        
      end      
    end
    if !@county.nil?
      return @county
    end
    nil
  end

  def count_team_exits
    CitizensQuestion.sum(:hours_moved)
  end

  def question_with_highest_exit_rate
    h = CitizensQuestion.group(:question_id).sum(:hours_moved).max_by {|k, v| v}
    if h 
        Refinery::Questions::Question.find(h[0])
    else
        nil
    end
  end

  def adepts_for_reward
    citizen_question = CitizensQuestion.group(:citizen_id).sum(:hours).max_by {|k, v| v}
    if !citizen_question.nil?
      return adept = { citizen: Refinery::Citizens::Citizen.find(citizen_question[0]), hours: citizen_question[1] }
    end
    nil
  end

  def reward_fond_amount
    Payment.sum(:total)
  end


  def self.compute_oph
    vv=CitizensQuestion.count_by_sql("select count(citizen_id) from citizens_questions group by question_id ORDER BY count(citizen_id) DESC LIMIT 1")


    Refinery::Questions::Question.all.each do |question|
      vn=question.citizens_questions.count
      hn=question.hours_done_sum
      pn=question.averege_hours_done
      k = (vv-vn)*pn
      oph=hn-k
   #   puts "vn:#{vn}, h:#{hn}, pn:#{pn}, k:#{k} OPH : #{oph}"
      question.update_attribute(:cache_oph, oph)
    end

    # nejvyšší počet voličů ze všech týmů = V vv
    # celkový počet voličů v týmu (dané otázky) = v(n)
    # celkový počet odpracovaných hodin = h(n)
    # průměrný počet hodin na 1 voliče toho kterého týmu = p(n)
    # penalizace (korekce) za počet voličů menší než V (nejvyšší dosažený počet) = k
    # k = (V-v)*p
    # OPH = h-k

  end

  def self.ophs
    Refinery::Questions::Question.where("NOT disabled AND cache_oph>0").order("cache_oph desc").limit(3)
  end










end
