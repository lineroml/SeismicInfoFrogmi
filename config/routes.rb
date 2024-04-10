Rails.application.routes.draw do
  resources :features, only: :index
end
