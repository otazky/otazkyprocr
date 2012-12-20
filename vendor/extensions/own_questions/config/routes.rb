Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :own_questions do
    resources :own_questions, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :own_questions, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :own_questions, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
