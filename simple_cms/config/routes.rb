Rails.application.routes.draw do

  resources :subjects do
    member do
      get :delete
    end
  end
end
