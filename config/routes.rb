Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  root to:'homes#top'
  get 'about', to: 'homes#about'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
