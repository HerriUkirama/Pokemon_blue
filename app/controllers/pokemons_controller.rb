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

                if @pokemon_skill.save
                    puts "skill berhasil di tambah"
                end
            end
            
            redirect_to pokemons_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    
    def destroy
        @pokemon = Pokemon.find(params[:id])
        
        @pokemon.destroy
        
        redirect_to pokemons_path
    end
    
    def heal
        @pokemon = Pokemon.find(params[:id])
        @pokemon_skills = @pokemon.pokemon_skills
        
        @pokemon.pokemon_hp = @pokemon.pokemon_max_hp
        @pokemon.status = "Free"
        @pokemon.save
        
        @pokemon_skills.each do |pokemon_skill|
            puts pokemon_skill.last_pp
            puts pokemon_skill.skill.pp
            pokemon_skill.last_pp = pokemon_skill.skill.pp
            pokemon_skill.save
        end
        
        redirect_to pokemon_path
        
    end
    
    def pokemon_params
        params.require(:pokemon).permit(:name, :pokedex_id)
    end
    
end
