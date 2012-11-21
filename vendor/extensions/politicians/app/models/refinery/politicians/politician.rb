module Refinery
  module Politicians
    class Politician < Refinery::Core::BaseModel
      self.table_name = 'refinery_politicians'
      inherits_from :subject

      attr_accessible :firstname, :lastname, :position, :photo_id

      acts_as_indexed :fields => [:firstname, :lastname]
      
      validates_presence_of :firstname, :lastname

      belongs_to :photo, :class_name => '::Refinery::Image'

      scope :active, joins(subject: :elections).where(refinery_elections: {done: false})

      def full_name
        "#{lastname}, #{firstname}"
      end
    end
  end
end
