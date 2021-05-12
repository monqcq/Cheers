Rails.application.routes.draw do
  root to:'homes#top'
  get 'about', to: 'homes#about'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: [:show] do
    collection do
      get 'my_page', to: 'users#my_page'
      get 'edit', to: 'users#edit'
      patch 'my_page', to: 'users#update'
    end
  end
end
