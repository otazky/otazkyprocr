module Refinery
  module Notices
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Notices

      engine_name :refinery_notices

      initializer "register refinerycms_notices plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "notices"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.notices_admin_notices_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/notices/notice'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Notices)
      end
    end
  end
end
