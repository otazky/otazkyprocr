module Refinery
  module OwnQuestions
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::OwnQuestions

      engine_name :refinery_own_questions

      initializer "register refinerycms_own_questions plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "own_questions"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.own_questions_admin_own_questions_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/own_questions/own_question'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::OwnQuestions)
      end
    end
  end
end
