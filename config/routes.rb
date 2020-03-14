Rails.application.routes.draw do
  namespace :v1 do
    resources :images, only: :index do
      collection do
        get :dimensions
      end
    end
  end
end
