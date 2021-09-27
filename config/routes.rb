Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :invoices do
    member do
      get :xhr_change_client_name
      patch :xhr_change_client_name
    end
  end

  root to: 'invoices#index'
end
