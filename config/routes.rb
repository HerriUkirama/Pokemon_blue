Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :pokemons do
    post :heal, on: :member
  end

  resources :pokedexs

  resources :battles do
    post :attack, on: :member
  end
  
  resources :histories


end
