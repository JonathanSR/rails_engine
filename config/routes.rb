Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: 'search_invoices#show'
        get'/find_all', to: 'search_invoices#index'
        get'/random', to: 'random_invoices#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find', to: 'search_items#show'
        get '/find_all', to: 'search_items#index'
        get '/random', to: 'random_items#show'
      end
      resources :items, only:[:index, :show]
      
      namespace :merchants do
        get '/find', to: 'search_merchants#show'
        get '/find_all', to: 'search_merchants#index'
        get '/random', to: 'random_merchants#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get '/find', to: 'search_customers#show'
        get '/find_all', to: 'search_customers#index'
        get '/random', to: 'random_customers#show'
      end
      resources :customers, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search_transactions#show'
        get '/find_all', to: 'search_transactions#index'
        get '/random', to: 'random_transactions#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :invoice_items do
        get '/find', to: 'search_invoice_items#show'
        get '/find_all', to: 'search_invoice_items#index'
        get '/random', to: 'random_invoice_items#show'
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
