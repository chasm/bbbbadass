Bbbbadass::Application.routes.draw do
  get "login" => "sessions#new", :as => :login
  post "login" => "sessions#create"
  
  get "logout" => "sessions#destroy", :as => :logout
  
  get "reset/:code" => "sessions#reset", :as => :password_form
  put "reset/:code" => "sessions#reset_password"
  
  get "uuids" => "site#uuids", :as => :uuid
  get "uuids/:count" => "site#uuids", :as => :uuids
  
  get "users" => "site#index", :as => :clients
  get "users/new" => "site#index", :as => :clients_new
  get "user/:id" => "site#index", :as => :client_detail
  get "user/:id/edit" => "site#index", :as => :client_edit

  scope "/api" do
    resources :users, :except => [ :new, :edit, :create ], defaults: {format: :json} do
      resources :phone_numbers, :except => [ :new, :edit, :create ], defaults: {format: :json}
      resources :street_addresses, :except => [ :new, :edit, :create ], defaults: {format: :json}
    end
  end
  
  root :to => 'site#index'
  
end
