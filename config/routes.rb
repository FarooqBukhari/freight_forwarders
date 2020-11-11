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
  resources :inquiries do
    collection do
      get :get_address_suggestions
    end
    resources :quotes, except: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
