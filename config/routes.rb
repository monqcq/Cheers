Rails.application.routes.draw do
  root to:'homes#top'
  get 'about', to: 'homes#about'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: [:show, :edit, :update] do
    # 以下、IDを持たせないためcollection
    collection do
      get 'my_page', to: 'users#my_page'
    end
  end
  
  resources :posts
end
