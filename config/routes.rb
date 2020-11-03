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
    resources :inquiries, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :inquiries, only: [:show, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
