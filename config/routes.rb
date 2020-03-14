Rails.application.routes.draw do
  namespace :v1 do
    resources :images, only: :index
  end
end
