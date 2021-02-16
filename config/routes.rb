Losap::Application.routes.draw do
  resources :members do
    resources :sleep_ins
    resources :standbys
    resources :collateraldutys
  end

  match '/members/:id/:year/:month' => 'members#show', :as => :member_month
  resources :locked_months
  resource :admin_console
  resources :admins
  resources :admin_sessions
  match 'reports' => 'reports#show', :as => :reports
  match 'reports/:date' => 'reports#show'
  match 'login' => 'admin_sessions#new', :as => :login
  match 'logout' => 'admin_sessions#destroy', :as => :logout
  root :to => 'members#index'
end

