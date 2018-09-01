Rails.application.routes.draw do
  use_doorkeeper
  resources :todos do
    resources :notes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
