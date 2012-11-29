Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :notices do
    resources :notices, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :notices, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :notices, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
