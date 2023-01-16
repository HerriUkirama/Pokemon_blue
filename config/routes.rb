Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :pokemons do
    get "/heal", to: "pokemons#heal", on: :member
    post "/heal", to: "pokemons#heal_for", on: :member
    # post :heal, on: :member
  end

  resources :pokedexs


end
