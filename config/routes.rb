Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: 'search_invoices#show'
        get'/find_all', to: 'search_invoices#index'
        get'/random', to: 'random_invoices#show'
        # get '/:id/transactions', to: 'invoices_transactions#index'
        # get '/:id/invoice_items', to: 'invoices_invoice_items#index'
        # get '/:id/items', to: 'invoices_items#index'
        # get '/:id/customer', to: 'invoices_customers#index'
        # get '/:id/merchant', to: 'invoices_merchants#index'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find', to: 'search_items#show'
        get '/find_all', to: 'search_items#index'
        get '/random', to: 'random_items#show'
        # get '/:id/invoice_items', to: 'items_invoice_items#index'
        # get '/:id/merchant', to: 'items_merchants#index'
      end
      resources :items, only:[:index, :show]

      namespace :merchants do
        get '/find', to: 'search_merchants#show'
        get '/find_all', to: 'search_merchants#index'
        get '/random', to: 'random_merchants#show'
        get '/:id/items', to: 'merchants_items#index'
        get '/:id/invoices', to: 'merchants_invoices#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get '/find', to: 'search_customers#show'
        get '/find_all', to: 'search_customers#index'
        get '/random', to: 'random_customers#show'
        # get '/:id/invoices', to: 'customers_invoices#index'
        # get '/:id/transactions', to: 'customers_transactions#index'
      end
      resources :customers, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search_transactions#show'
        get '/find_all', to: 'search_transactions#index'
        get '/random', to: 'random_transactions#show'
        # get '/:id/invoice', to: 'transactions_invoices#index'
      end
      resources :transactions, only: [:index, :show]

      namespace :invoice_items do
        get '/find', to: 'search_invoice_items#show'
        get '/find_all', to: 'search_invoice_items#index'
        get '/random', to: 'random_invoice_items#show'
        # get '/:id/invoice', to: 'invoices_items_invoices#index'
        # get '/:id/item', to: 'invoices_items_items#index'
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
