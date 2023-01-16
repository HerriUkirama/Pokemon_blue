class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.all
    end
    
    def new
        @pokemon = Pokemon.new
        @pokedexes = Pokedex.all
    end

    def show
        @pokemon = Pokemon.find(params[:id])
        @pokedex = Pokedex.find(@pokemon.pokedex_id)
        @pokemon_skills = @pokemon.pokemon_skills
    end
    

    def create
        @pokemon = Pokemon.new(pokemon_params)
        @pokedex = Pokedex.find(@pokemon.pokedex_id)
        @initiate_skills = @pokedex.skills



        @pokemon.pokemon_attack = @pokedex.attack
        @pokemon.pokemon_defence = @pokedex.defence
        @pokemon.pokemon_speed = @pokedex.speed
        @pokemon.pokemon_special = @pokedex.special
        @pokemon.pokemon_max_exp = @pokedex.max_exp
        @pokemon.pokemon_max_hp = @pokedex.max_hp
        @pokemon.pokemon_hp = @pokedex.max_hp
        
        if @pokemon.save
            
            @initiate_skills.each do |skill|
                @pokemon_skill = PokemonSkill.new
                @pokemon_skill.pokemon_id = @pokemon.id
                @pokemon_skill.skill_id = skill.id
                @pokemon_skill.last_pp = skill.pp

                @pokemon_skill.save
            end
            
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
    
    def heal
        puts "masok sini bwang"

        # redirect_to pokemons_path
        # @pokemon = Pokemon.find(params[:id])
        # @pokemon_skill = @pokemon.pokemon_skills.first

        # @pokemon_skill.skill_id = 6
        
        # if @pokemon_skill.save
        #     redirect_to pokemons_path
        # else
        #     render :new, status: :unprocessable_entity
        # end
    end
    def heal_for
        puts "masok sini bwang 2"

        redirect_to pokemons_path
        # @pokemon = Pokemon.find(params[:id])
        # @pokemon_skill = @pokemon.pokemon_skills.first

        # @pokemon_skill.skill_id = 6
        
        # if @pokemon_skill.save
        #     redirect_to pokemons_path
        # else
        #     render :new, status: :unprocessable_entity
        # end
    end
    
    
end
