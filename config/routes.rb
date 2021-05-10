Rails.application.routes.draw do
  root to:'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
