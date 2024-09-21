Rails.application.routes.draw do
  devise_for :users, path:'', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, 
  defaults: { format: :json }

  namespace :v1 do
    post 'groups/create', to: 'groups#create'
    get 'groups', to: 'groups#retrieve'
  end
end
