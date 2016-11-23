Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'logout', to: 'welcome#logout'

  devise_for :users, :controllers => { sessions: 'sessions', registrations: 'registrations' }

  resources :hero
  resources :item, :except => [:new, :edit]
end
