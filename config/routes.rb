Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: 'search_invoices#show'
      end
      resources :invoices, only: [:index, :show]
    end
  end

end
