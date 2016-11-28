Rails.application.routes.draw do
  root 'welcome#index'

  get 'logout', to: 'welcome#logout'

  devise_scope :admin do
    get 'admins' => 'admin/sessions#new'
  end
  devise_for :admins, :controllers => { sessions: 'admin/sessions', registrations: 'admin/registrations' }
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :hero, :admin
  resources :item, :except => [:new, :edit]
end
