class Battle < ApplicationRecord
    belongs_to :pokemon_i, class_name: 'Pokemon'
    belongs_to :pokemon_ii, class_name: 'Pokemon'
    belongs_to :winner, class_name: 'Pokemon', optional: true
    belongs_to :current_attacker, class_name: 'Pokemon', optional: true

    has_many :battle_details

    validates :pokemon_i, comparison: { other_than: :pokemon_ii, message: "coba2 aja bang"  } , on: :create

    validate :pokemon_hp_validation, on: :create

    def pokemon_hp_validation
        pokemon1 = Pokemon.find(pokemon_i_id)
        pokemon2 = Pokemon.find(pokemon_ii_id)
        if pokemon1.pokemon_hp == 0
            errors.add(:pokemon_i_id, "Pokemon is Death")
        elsif pokemon2.pokemon_hp == 0
            errors.add(:pokemon_ii_id, "Pokemon is Death")
        end
    end
    
end
