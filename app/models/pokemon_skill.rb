class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
end
