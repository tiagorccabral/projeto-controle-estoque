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
    resources :inventory_items
    resources :categories
    resources :report_lists
    resources :lost_items
    get '/inventory_list', to: 'inventory_items#inventory_list'
    get 'compare_charts', to: 'time_charts#chart_new'
    post 'compare_charts', to: 'time_charts#chart_create'
    get '/items_list', to: 'items#items_list'
    put '/sell_item', to: 'items#sell'
    patch '/update_lost_item', to: 'items#lost_item'
    get '/sold_list', to: 'sold_items#index'
  end

end
