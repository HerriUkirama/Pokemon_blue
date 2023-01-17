class Battle < ApplicationRecord
    belongs_to :pokemon_i, class_name: 'Pokemon'
    belongs_to :pokemon_ii, class_name: 'Pokemon'
    belongs_to :winner, class_name: 'Pokemon', optional: true
    belongs_to :current_attacker, class_name: 'Pokemon', optional: true

    has_many :battle_details
end
