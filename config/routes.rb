Rails.application.routes.draw do
  root 'welcome#index'
  resources :users do
    collection do
      post '/login', to: 'users#login'
    end
    collection do
      get '/check', to: 'users#check'
    end
    collection do
      delete '/destroyCookie', to: 'users#destroyCookie'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
