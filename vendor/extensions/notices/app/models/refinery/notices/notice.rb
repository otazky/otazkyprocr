module Refinery
  module Notices
    class Notice < Refinery::Core::BaseModel
      self.table_name = 'refinery_notices'

      attr_accessible :title, :content, :link, :img, :position , :img_id

      acts_as_indexed :fields => [:title, :content, :link]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :img, :class_name => '::Refinery::Image'
    end
  end
end
