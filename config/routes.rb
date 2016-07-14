Rails.application.routes.draw do
  scope '/api/v1' do
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
