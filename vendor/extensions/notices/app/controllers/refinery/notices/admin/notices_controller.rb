module Refinery
  module Notices
    module Admin
      class NoticesController < ::Refinery::AdminController

        crudify :'refinery/notices/notice', :xhr_paging => true

      end
    end
  end
end
