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
      get :friends
    end
  end
  resources :inquiries do
    collection do
      get :get_address_suggestions
    end
    resources :quotes, except: [:index] do
      member do
        patch :select_quote
        patch :deselect_quote
      end
    end
  end

  resources :friends, only: [:index, :create]
  post "/friends/add" => "friends/add", as: :add_friend
  post "/friends/reject" => "friends/reject", as: :reject_friend
  post "/friends/remove" => "friends/remove", as: :remove_friend
  post "/friends/cancel" => "friends/cancel", as: :cancel_request
  # get "/friends/search" => "friends/search"
  # post "/friends/search" => "friends/search"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :conversations, only: [:create] do
    member do
      post :close
    end
  end
  resources :messages, only: [:index] do
    member do
      post :read
    end
  end
end
