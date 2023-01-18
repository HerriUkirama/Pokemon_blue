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
        @battle_detail = BattleDetail.new(battle_detail_params)
        
        @battle = Battle.find(@battle_detail.battle_id)
        @@pokemon_attack = Pokemon.find(params[:pokemon_attack_id])
        @@pokemon_got_damage = Pokemon.find(params[:pokemon_got_damage_id])
        @@pokemon_skill = PokemonSkill.find(params[:pokemon_skill_id])

        @@pokemon_skill.last_pp -= 1
        @@pokemon_skill.save

        damage = damage_calculation()

        if @@pokemon_got_damage.pokemon_hp > damage
            @@pokemon_got_damage.pokemon_hp -= damage
            @@pokemon_got_damage.save
        else
            @@pokemon_got_damage.pokemon_hp -= @@pokemon_got_damage.pokemon_hp
            @@pokemon_got_damage.save
        end

        if winner_check 
            puts @battle.id
            @battle.winner_id = @@pokemon_attack.id
            @battle.status = "End"
            @battle.save
        end

        puts winner_check()

        puts damage_calculation()

        puts @battle.id
        puts @@pokemon_attack.name
        puts @@pokemon_attack.pokemon_attack
        puts @@pokemon_attack.pokemon_defence
        puts @@pokemon_got_damage.name
        puts @@pokemon_skill.skill.power
        redirect_to battle_path
    end
    
    def damage_calculation
        hasil = @@pokemon_attack.pokemon_attack.to_f / @@pokemon_got_damage.pokemon_defence.to_f * @@pokemon_skill.skill.power.to_f
        hasil.to_i
    end

    def winner_check
        @@pokemon_got_damage.pokemon_hp == 0 ? true : false
    end
    
    


    def battle_params
        params.require(:battle).permit(:pokemon_i_id, :pokemon_ii_id)
    end
    def battle_detail_params
        params.require(:battle_detail).permit(:battle_id, :pokemon_id)
    end
    
    
end
