Rails.application.routes.draw do
  resources :categories

  resources :menu_items
  resources :categories, only: :index

  resources :blank_pages, only: :index

  root 'categories#index'
end
