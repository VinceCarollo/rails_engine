Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/revenue', to: 'revenue#show'
        get '/most_items', to: 'items#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/items', to: "merchants/items#index"
        get '/invoices', to: "merchants/invoices#index"
        get '/revenue', to: 'merchants/total_revenue#show'
        get '/favorite_customer', to: 'merchants/customers#show'
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
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :customers, only: [:index, :show] do
        get '/invoices', to: 'customers/invoices#index'
        get '/transactions', to: 'customers/transactions#index'
        get '/favorite_merchant', to: 'customers/merchants#show'
      end
      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'transactions/invoices#show'
      end
      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoice_items/invoices#show'
        get '/item', to: 'invoice_items/items#show'
      end
    end
  end

end
