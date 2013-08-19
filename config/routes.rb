CbMorning::Application.routes.draw do
  resources :menu_items
  resources :categories, only: :index

  root 'categories#index'
end
