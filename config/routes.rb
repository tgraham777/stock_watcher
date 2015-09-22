Rails.application.routes.draw do
  root 'welcome#show'

  get '/logout', to: 'welcome#show'

  resources :stocks
end
