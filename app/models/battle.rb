class Battle < ApplicationRecord
    belongs_to :pokemon_i, class_name: 'Pokemon'
    belongs_to :pokemon_ii, class_name: 'Pokemon'
    belongs_to :winner, class_name: 'Pokemon', optional: true
    belongs_to :current_attacker, class_name: 'Pokemon', optional: true

    has_many :battle_details, dependent: :destroy

    belongs_to :skill, optional: true
    
    validates :pokemon_ii, comparison: { other_than: :pokemon_i, message: "Pokemon can't same"  } , on: :create

    validate :pokemon_not_nil_validation, on: :create
    validate :pokemon_hp_validation, on: :create
    validate :pokemon_pp_validation, on: :create
    validate :pokemon_in_battle_validation, on: :create

    def pokemon_not_nil_validation
        if pokemon_i_id == 0  && pokemon_ii_id ==0
            errors.add(:pokemon_i_id, "must exist")
            errors.add(:pokemon_ii_id, "must exist")
        elsif pokemon_i_id == 0
            errors.add(:pokemon_i_id, "must exist")
        elsif pokemon_ii_id == 0
            errors.add(:pokemon_ii_id, "must exist")
        end
    end
    
    def pokemon_hp_validation
        @pokemon1 = Pokemon.find(pokemon_i_id)
        @pokemon2 = Pokemon.find(pokemon_ii_id)
        if @pokemon1.pokemon_hp == 0 && @pokemon2.pokemon_hp == 0
            errors.add(:pokemon_i_id, "Pokemon is Death")
            errors.add(:pokemon_ii_id, "Pokemon is Death")
        elsif @pokemon1.pokemon_hp == 0
            errors.add(:pokemon_i_id, "Pokemon is Death")
        elsif @pokemon2.pokemon_hp == 0
            errors.add(:pokemon_ii_id, "Pokemon is Death")
        end
    end

    def pokemon_pp_validation
        @pokemon1 = Pokemon.find(pokemon_i_id)
        @pokemon2 = Pokemon.find(pokemon_ii_id)
        @pokemon1_skills_check = @pokemon1.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}
        @pokemon2_skills_check = @pokemon2.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}

        if @pokemon1_skills_check && @pokemon2_skills_check
            errors.add(:pokemon_i_id, "All Pokemon Skills don't Have PP")
            errors.add(:pokemon_ii_id, "All Pokemon Skills don't Have PP")
        elsif @pokemon1_skills_check
            errors.add(:pokemon_i_id, "All Pokemon Skills don't Have PP")
        elsif @pokemon2_skills_check
            errors.add(:pokemon_ii_id, "All Pokemon Skills don't Have PP")
        end

    end
    
    def pokemon_in_battle_validation
        @pokemon1 = Pokemon.find(pokemon_i_id)
        @pokemon2 = Pokemon.find(pokemon_ii_id)

        if @pokemon1.status == "In Battle" && @pokemon2.status == "In Battle"
            errors.add(:pokemon_i_id, "Pokemon In a Battle")
            errors.add(:pokemon_ii_id, "Pokemon In a Battle")
        elsif @pokemon1.status == "In Battle"
            errors.add(:pokemon_i_id, "Pokemon In a Battle")
        elsif @pokemon2.status == "In Battle"
            errors.add(:pokemon_ii_id, "Pokemon In a Battle")
        end
    end
    
end
