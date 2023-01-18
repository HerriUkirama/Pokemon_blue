class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
    validate :number_of_pokemon_skills_validation, on: :create

    def number_of_pokemon_skills_validation
        puts "masuk validation skill"
        if  pokemon.pokemon_skills.count >= 4
            errors.add(:pokemon_id, "Skills should not be more than 4")
        end
    end
    
end
