Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}, only: [:show, :index] do
    resources :payments, only: [:show, :index, :create]
  end
end
