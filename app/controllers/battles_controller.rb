class BattlesController < ApplicationController
    def index
        @battles = Battle.all
    end

    def new
        @battle  = Battle.new
        @pokemons = Pokemon.all
    end

    def show
        @battle = Battle.find(params[:id])
        @pokemon_i = Pokemon.find(@battle.pokemon_i_id)
        @pokemon_ii = Pokemon.find(@battle.pokemon_ii_id)
        @pokemon_i_skills = @pokemon_i.pokemon_skills
        @pokemon_ii_skills = @pokemon_ii.pokemon_skills
    end
    
    
    def create
        @battle = Battle.new(battle_params)
        @battle.battle_date = Time.now
        
        if @battle.pokemon_i.pokemon_speed >= @battle.pokemon_ii.pokemon_speed 
            @battle.current_attacker_id = @battle.pokemon_i_id
        elsif @battle.pokemon_i.pokemon_speed < @battle.pokemon_ii.pokemon_speed
            @battle.current_attacker_id = @battle.pokemon_ii_id
        end

        
        
        if @battle.pokemon_i_id == @battle.pokemon_ii_id
            redirect_to new_battle_path
        elsif @battle.save
            @battle.pokemon_i.status ="In Battle"
            @battle.pokemon_ii.status ="In Battle"
            @battle.pokemon_i.save
            @battle.pokemon_ii.save
            redirect_to battle_path(@battle)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @battle = Battle.find(params[:id])

        @battle.destroy

        redirect_to battles_path
    end
    
    def attack
        puts "hellow babang"
        @attack = Battle.new(battle_params)
        redirect_to battle_path
    end
    



    def battle_params
        params.require(:battle).permit(:pokemon_i_id, :pokemon_ii_id)
    end
    
end
