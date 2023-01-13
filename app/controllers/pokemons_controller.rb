class PokemonsController < ApplicationController
    def index
    end
    
    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.new(name: params[:name])
        
        if @pokemon.save
            redirect_to pokemons_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    
end
