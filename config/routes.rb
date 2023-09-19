Rails.application.routes.draw do
  resources :static_pages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#new"
end
