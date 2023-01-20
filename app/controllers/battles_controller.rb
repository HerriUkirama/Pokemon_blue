class BattlesController < ApplicationController
    $element_chart = {"Fire" => {"Fire" => 1, "Water" => 0.5, "Grass" => 2, "Normal" => 1},
                    "Water" => {"Fire" => 2, "Water" => 1, "Grass" => 0.5, "Normal" => 1},
                    "Grass" => {"Fire" => 0.5, "Water" => 2, "Grass" => 1, "Normal" => 1},
                    "Normal" => {"Fire" => 1, "Water" => 1, "Grass" => 1, "Normal" => 1}
    }

    $max_exp = { 1=>100, 2=>110, 3=>120, 4=>130, 5=>140, 6=>150, 7=>160, 8=>170, 9=>180, 10=>190, 11=>200, 12=>210, 13=>220, 14=>230, 15=>240, 16=>250, 17=>260, 18=>270, 19=>280, 20=>290, 21=>300, 22=>310, 23=>320, 24=>330, 25=>340, 
        26=>350, 27=>360, 28=>370, 29=>380, 30=>390, 31=>400, 32=>410, 33=>420, 34=>430, 35=>440, 36=>450, 37=>460, 38=>470, 39=>480, 40=>490, 41=>500, 42=>510, 43=>520, 44=>530, 45=>540, 46=>550, 47=>560, 48=>570, 49=>580, 50=>590, 
        51=>600, 52=>610, 53=>620, 54=>630, 55=>640, 56=>650, 57=>660, 58=>670, 59=>680, 60=>690, 61=>700, 62=>710, 63=>720, 64=>730, 65=>740, 66=>750, 67=>760, 68=>770, 69=>780, 70=>790, 71=>800, 72=>810, 73=>820, 74=>830, 75=>840, 
        76=>850, 77=>860, 78=>870, 79=>880, 80=>890, 81=>900, 82=>910, 83=>920, 84=>930, 85=>940, 86=>950, 87=>960, 88=>970, 89=>980, 90=>990, 91=>1000, 92=>1010, 93=>1020, 94=>1030, 95=>1040, 96=>1050, 97=>1060, 98=>1070, 99=>1080,100=>1090
    }

    LEVEL_MAX = 100

    $exp = 500

    def index
        @battles = Battle.all
    end

    def new
        @battle  = Battle.new
        @pokemons = Pokemon.all 
        $skills = Array.new
    end

    def show
        @battle = Battle.find(params[:id])
        # @pokemons = Pokemon.all
        @pokemon_i = Pokemon.find(@battle.pokemon_i_id)
        @pokemon_ii = Pokemon.find(@battle.pokemon_ii_id)
        @pokemon_i_skills = @pokemon_i.pokemon_skills
        @pokemon_ii_skills = @pokemon_ii.pokemon_skills

        # puts "ini tambah skill", $skills
    end
    
    
    def create
        @battle = Battle.new(battle_params)
        @battle.battle_date = Time.now
        
        if @battle.pokemon_i_id != 0 && @battle.pokemon_ii_id != 0
            puts @battle.pokemon_i_id
            if @battle.pokemon_i.pokemon_speed >= @battle.pokemon_ii.pokemon_speed 
                @battle.current_attacker_id = @battle.pokemon_i_id
            elsif @battle.pokemon_i.pokemon_speed < @battle.pokemon_ii.pokemon_speed
                @battle.current_attacker_id = @battle.pokemon_ii_id
            end
        end


        if @battle.save
            @battle.pokemon_i.status ="In Battle"
            @battle.pokemon_ii.status ="In Battle"
            @battle.pokemon_i.save
            @battle.pokemon_ii.save
            redirect_to battle_path(@battle)
        else

            @pokemons = Pokemon.all
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @battle = Battle.find(params[:id])

        @battle.destroy

        redirect_to battles_path
    end
    
    def attack
        @battle_detail = BattleDetail.new(battle_detail_params)
        
        # puts "battle detail",  @battle_detail

        @battle = Battle.find(@battle_detail.battle_id)
        
        @@pokemon_attack = Pokemon.find(params[:pokemon_attack_id])
        @@pokemon_got_damage = Pokemon.find(params[:pokemon_got_damage_id])
        @@pokemon_skill = PokemonSkill.find(@battle_detail.skill_id)
        
        # Decrement pp and calculate damage 
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
        
        @battle_detail.skill_id = @@pokemon_skill.skill_id
        @battle_detail.damage = damage
        @battle_detail.enemy_hp = @@pokemon_got_damage.pokemon_hp
        @battle_detail.save
        # End

        # Update battle winner and status on pokemon
        if hp_check or pp_check
            @battle.winner_id = @@pokemon_attack.id
            @battle.status = "End"
            
            attacker_pp = @@pokemon_attack.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}

            if hp_check
                @@pokemon_got_damage.status = "Death"
                @@pokemon_got_damage.save
            elsif pp_check
                @@pokemon_got_damage.status = "No PP"
                @@pokemon_got_damage.save
            end

            @@pokemon_attack.status = "Free"
            @@pokemon_attack.save
            if attacker_pp
                @@pokemon_attack.status = "No PP"
                @@pokemon_attack.save
            end

            exp_winner = @@pokemon_attack.pokemon_exp + $exp
            if exp_winner >= @@pokemon_attack.pokemon_max_exp
                # puts "masuk sini kk"
                # Level_up state
                @battle.level_up = true
                @battle.pokemon_level_up_id = @@pokemon_attack.id
                @battle.save
                if @battle.level_up
                    # puts "level up"
                    level_up()
                end

                if $skills.length != 0
                    z = 3
                    
                    while @battle.winner.pokemon_skills.count < 4
                        skill = $skills.shift

                        @new_skill = Skill.find(skill)
                        @pokemon_skill = PokemonSkill.new
                        @pokemon_skill.pokemon_id = @battle.winner_id
                        @pokemon_skill.skill_id = skill
                        @pokemon_skill.last_pp = @new_skill.pp
                        @pokemon_skill.save

                    end 
                    
                    if $skills.length != 0

                        @battle.skill_id = $skills.shift
                        @battle.pokemon_get_new_skill_id = @@pokemon_attack.id
                        # @battle.change_skill = true
                        @battle.get_new_skill= true
                        @battle.skills_slot_full = true
                        # @battle.save

                    end
                end
                # End
            elsif exp_winner < @@pokemon_attack.pokemon_max_exp
                # puts "mask sini kakak"
                @@pokemon_attack.pokemon_exp = exp_winner
                @@pokemon_attack.save   
            end
            # puts "ini di luar"

            @battle.save
        end
        # End

        # Change Attacker
        @battle.current_attacker_id = @@pokemon_got_damage.id
        @battle.save
        # End
        redirect_to battle_path
    end

    def level_up
        pokemon_level = @@pokemon_attack.level
        max_exp = $max_exp[pokemon_level]
        curr_exp = @@pokemon_attack.pokemon_exp + $exp
        # puts "curr exp : ", curr_exp
        # iteration = 0

        while curr_exp >= max_exp
            @@pokemon_attack.level = @@pokemon_attack.level + 1

            new_skill = Skill.where("level = ?  and  element = ? ", @@pokemon_attack.level,@@pokemon_attack.pokedex.element_1 )

            if new_skill.length != 0
                # puts "nambah skill"
                for x  in 0..(new_skill.length-1)
                    $skills.push(new_skill[x].id)
                end
            end
            @@pokemon_attack.pokemon_attack = @@pokemon_attack.pokemon_attack + rand(5..10)
            @@pokemon_attack.pokemon_defence = @@pokemon_attack.pokemon_defence + rand(5..10)
            @@pokemon_attack.pokemon_speed = @@pokemon_attack.pokemon_speed + rand(5..10)
            @@pokemon_attack.pokemon_special = @@pokemon_attack.pokemon_special + rand(5..10)

            hp_rand = rand(5..10)

            @@pokemon_attack.pokemon_max_hp = @@pokemon_attack.pokemon_max_hp + hp_rand
            @@pokemon_attack.pokemon_hp = @@pokemon_attack.pokemon_hp + hp_rand
            @@pokemon_attack.pokemon_exp = curr_exp - max_exp
            @@pokemon_attack.pokemon_max_exp = $max_exp[pokemon_level+1]
            @@pokemon_attack.save

            curr_exp -= max_exp
            pokemon_level += 1
            max_exp = $max_exp[pokemon_level]
        end
    end

    def change_skill_state
        # puts "ganti babang"
        @battle = Battle.find(params[:id])
        @battle.change_skill = true
        @battle.save
        # puts @battle.id
        redirect_to battle_path
    end
    
    def dont_change_or_add_skill_state
        # puts "gak ganti babang"
        @battle = Battle.find(params[:id])
        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @@pokemon_attack.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.save
        redirect_to battle_path
    end
    
    def change_skill
        # puts "masuk ke change skill"
        # puts params[:pokemon_id]
        # puts params[:pokemon_skill_id]

        @battle = Battle.find(params[:battle_id])
        @pokemon_skill = PokemonSkill.find(params[:pokemon_skill_id])

        @pokemon_skill.skill_id = @battle.skill_id
        @pokemon_skill.last_pp = @battle.skill.pp
        @pokemon_skill.save

        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @@pokemon_attack.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.save

        redirect_to  battle_path
    end
    
    def add_skill
        @battle = Battle.find(params[:id])
        @pokemon_skill = PokemonSkill.new
        @pokemon_skill.pokemon_id = @battle.winner_id
        @pokemon_skill.skill_id = @battle.skill_id
        @pokemon_skill.last_pp = @battle.skill.pp
        @pokemon_skill.save

        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @battle.winner.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.save
        redirect_to battle_path
    end
    
    
    def damage_calculation
        multipier = $element_chart[@@pokemon_attack.pokedex.element_1][@@pokemon_got_damage.pokedex.element_1]
        hasil = (@@pokemon_attack.pokemon_attack.to_f  + @@pokemon_skill.skill.power.to_f - @@pokemon_got_damage.pokemon_defence.to_f)  * multipier
        if hasil < 0 
            hasil = 0
        end
        hasil.to_i
    end
    
    def hp_check
        @@pokemon_got_damage.pokemon_hp == 0 ? true : false
    end

    def pp_check
        skills_pp = @@pokemon_got_damage.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}
        skills_pp
    end
    

    def battle_params
        params.require(:battle).permit(:pokemon_i_id, :pokemon_ii_id)
    end

    def battle_detail_params
        params.require(:battle_detail).permit(:battle_id, :pokemon_id, :skill_id)
    end
    
    
end
