Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  resources :merchants, only:[:show] do
    resources :items, except:[:destroy]
    resources :item_status, only:[:update]
    resources :invoices, only:[:index, :show]
    resources :invoice_items, only: [:update]
    resources :dashboard, only:[:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create, :edit, :new]
    resources :invoices, only: [:index, :show, :update]
  end

  get '/admin/merchants/new', to: 'admin/merchants#new'
  patch '/admin/merchants', to: 'admin/merchants#update'
end
