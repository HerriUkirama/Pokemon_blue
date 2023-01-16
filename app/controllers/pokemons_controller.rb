class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.all
    end
    
    def new
        @pokemon = Pokemon.new
        @pokedexes = Pokedex.all
    end

    def create
        @pokemon = Pokemon.new(pokemon_params)
        @pokedex = Pokedex.find(@pokemon.pokedex_id)

        @pokemon.pokemon_attack = @pokedex.attack
        @pokemon.pokemon_defence = @pokedex.defence
        @pokemon.pokemon_speed = @pokedex.speed
        @pokemon.pokemon_special = @pokedex.special
        @pokemon.pokemon_max_exp = @pokedex.max_exp
        @pokemon.pokemon_max_hp = @pokedex.max_hp
        @pokemon.pokemon_hp = @pokedex.max_hp
        
        if @pokemon.save
            redirect_to pokemons_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def pokemon_params
        params.require(:pokemon).permit(:name, :pokedex_id)
    end

    def destroy
        @pokemon = Pokemon.find(params[:id])

        @pokemon.destroy

        redirect_to pokemons_path
    end
    
    
end
