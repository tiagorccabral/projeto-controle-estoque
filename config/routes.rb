Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index', as: '/'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }, :skip => [:registrations]


  namespace :backoffice do
    get '/admin', to: 'dashboard#index'
    resources :users
    resources :items
    get '/items_list', to: 'items#items_list'
  end

end
