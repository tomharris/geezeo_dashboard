GeezeoDashboard::Application.routes.draw do

  root :to => 'sessions#new'

  resource :sessions, :only => [:new, :create, :destroy]
  get 'dashboard' => 'dashboard#show'
end
