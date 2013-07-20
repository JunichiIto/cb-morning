CbMorning::Application.routes.draw do
  resources :menu_items

  root 'home#index'
end
