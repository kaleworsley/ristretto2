Ristretto::Application.routes.draw do

  resources :timeslices

  resources :tickets

  resources :projects, :only => [:index]
  match '/projects/:state' => 'projects#index'

  resources :customers do
    resources :contacts, :except => [:show]
    resources :projects do
      resources :timeslices, :only => [:new, :create]
      resources :stakeholders, :except => [:show]
      resource :proposal, :except => [:new]
    end
  end

  devise_for :users do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/register' => 'devise/registrations#new', :as => :new_user_registration
  end

  match '/' => 'dashboard#show', :as => :dashboard
  root :to => 'dashboard#show'
  match ':static' => 'static#show'
end

