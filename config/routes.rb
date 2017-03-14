Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: 'search_invoices#show'
        get'/find_all', to: 'search_invoices#index'
        get'/random', to: 'random_invoices#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'search_merchants#show'
        get '/find_all', to: 'search_merchants#index'
        get '/random', to: 'random_merchants#show'
      end
      resources :merchants, only: [:index, :show]

      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
