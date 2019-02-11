Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ideas do
    resources :reviews, only: [:new, :create, :destroy]
  end
  get("/", to: "ideas#index", as: :root)

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
end
