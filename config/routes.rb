Rails.application.routes.draw do
  devise_for :users, path:'', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }, 
  defaults: { format: :json }

  namespace :v1 do
    get 'groups', to: 'groups#retrieve'
    post 'groups/create', to: 'groups#create'
    resources :groups, only: [:update, :destroy]
    resources :estates, only: [:update, :create, :index, :show, :destroy] do
      collection do
        get :preview_data
      end
    end
    resources :estate_ratings, only: [:index, :show, :create, :update, :destroy]
    resources :estate_comments, only: [:index, :show, :create, :update, :destroy]
    resources :subcomments, only: [:index, :show, :create, :update, :destroy]
    resources :messages, only: [:index, :create]
    resources :users, only: [:index]
    resources :channels, only: [:show, :index] do
      member do  
        post :add_to_channel
      end
    end
  end
end
