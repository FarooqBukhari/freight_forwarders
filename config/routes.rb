Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {:registrations => "users/registrations"}
  devise_scope :user do
    # authenticated :user do
    #   root 'home#index', as: :authenticated_root
    # end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    authenticated do
      root 'home#index'
    end
  end
  resources :after_signup
  resources :users do
    member do
      get :my_inquiries
    end
  end
  resources :inquiries

  resources :friends, only: [:index, :create]
  post "/friends/add" => "friends/add", as: :add_friend
  post "/friends/reject" => "friends/reject", as: :reject_friend
  post "/friends/remove" => "friends/remove", as: :remove_friend
  post "/friends/cancel" => "friends/cancel", as: :cancel_request
  # get "/friends/search" => "friends/search"
  # post "/friends/search" => "friends/search"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
