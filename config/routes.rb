Rails.application.routes.draw do

  root 'welcome#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  
  #so that we can have the uri listings/:id/tags
  resources :listings do 
    resources :tags
  end

  resources :users do 
    resources :listings
  end

  resources :bookings, only: [:create, :destroy]


  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/users/:id" => "users#show", as: "profile"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/listings/index" => "listings#index"
  get "/users/index" => "users#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
