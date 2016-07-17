Rails.application.routes.draw do

  resources :maps, only: [:show] do
    member do
      put :move
      put :restart
    end
  end

  namespace :api do
    namespace :v1 do
      resources :taxis, only: [:create, :show]
      resources :passengers, only: [:create, :show]

      resources :maps, only: [:create, :show, :index] do
        member do
          put :move
          put :restart
          get :detail
        end
      end
    end
  end
end
