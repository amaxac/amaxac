Rails.application.routes.draw do
  resources :images do
    collection do
      get 'search'
      get 'unknown' => 'images#unknown'
      get 'random.jpg' => 'images#random', as: :random
      get 'autocomplete'
      get 'add'
      post 'add'
    end
    
    member do
      post 'publish'
      post 'klass'
    end
  end

  get '/admin' => 'application#admin'

  root to: "images#search"
end
