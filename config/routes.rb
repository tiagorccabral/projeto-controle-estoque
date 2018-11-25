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
    resources :time_charts
    get 'time_charts/compare_chart', to: 'time_charts#chart_new'
    post 'time_charts/compare_chart', to: 'time_charts#chart_create'
    get '/items_list', to: 'items#items_list'
  end

end
