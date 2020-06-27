Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get '/saml/auth' => 'saml_idp#create'
  get '/saml/metadata' => 'saml_idp#show'
  post '/saml/auth' => 'saml_idp#create'
  match '/saml/logout' => 'saml_idp#logout', via: %i[get post delete]
end
