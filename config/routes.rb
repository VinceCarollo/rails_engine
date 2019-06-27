Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items#show'
        get '/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/items', to: "merchants/items#index"
        get '/invoices', to: "merchants/invoices#index"
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :items, only: [:index, :show] do
        get "/invoice_items", to: 'items/invoice_items#index'
        get "/merchant", to: 'items/merchants#show'
      end
    end
  end

end
