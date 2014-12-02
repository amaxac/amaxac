Rails.application.routes.draw do
  resources :images do
    collection do
      get 'search', as: :search
      get 'unknown' => 'images#unknown', as: :unknown
      get 'random.jpg' => 'images#random', as: :random
      get 'autocomplete', as: :autocomplete
      get 'add', as: :add
      post 'add'
    end
    
    member do
      post 'publish', as: :publish
    end
  end

  get '/admin' => 'application#admin'

  root to: "images#search"
end
