Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords], path: 'api', controllers: {
    sessions: 'admin/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resource :posts, only: [:create, :destroy] do
      get 'search'
    end
    resources :threads, only: [:index, :show]
    resources :staffs, only: [:index, :create, :update]
    resources :complaints
    resources :blocklists, only: [:index, :create, :update, :destroy]
    get 'config', to: 'config#index'
  end
end
