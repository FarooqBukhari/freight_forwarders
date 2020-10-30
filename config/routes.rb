Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "users/registrations"}
  devise_scope :user do
    # authenticated :user do
    #   root 'home#index', as: :authenticated_root
    # end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :after_signup
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
