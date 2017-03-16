Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], path: 'api', controllers: {
    sessions: 'admin/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :posts, only: [:create, :destroy]
    resources :threads, only: [:index, :show]
    get 'recaptcha', to: 'recaptcha#index'
  end
end