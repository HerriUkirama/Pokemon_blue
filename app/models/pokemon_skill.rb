class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
    validate :number_of_pokemon_skills_validation, on: :create
    validate :pokemon_level_to_skill_level
    validate :pokemon_pp_to_skill_pp
    validate :pokemon_element_to_skill_element

    # validate :check_pokemon_in_battle

    validates :skill , uniqueness: { scope: :pokemon_id }

    private

    
    def number_of_pokemon_skills_validation
        if  pokemon.pokemon_skills.count >= 4
            errors.add(:pokemon_id, "Skills should not be more than 4")
        end
    end
    
    
    def pokemon_level_to_skill_level
        if pokemon.level < skill.level
            errors.add(:pokemon_id, "Pokemon has not yet reached the level of this skill")
        end
    end
    
    def pokemon_pp_to_skill_pp
        if self.last_pp > skill.pp
            puts "last pp gak bisa berle"
            errors.add(:last_pp, "Pokemon Skill PP cannot be exceed " + skill.pp.to_s)
        end
    end
    
    def pokemon_element_to_skill_element
        # puts self.pokemon.pokedex
        puts "halo babang"
        if pokemon.pokedex.element_1 != skill.element and pokemon.pokedex.element_2 != skill.element
            puts "element gak sama"
            errors.add(:skill_id, "Pokemon elements and skills are not the same")
        end
    end
    
    # def heal_validation
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.pokemon_id, self.pokemon_id])
    #     battles_check = battles.any? {|battle| battle.status == "In Battle"}
    #     if battles_check
    #         errors.add(:pokemon_id, "Pokemon can't update because pokemon is in battle")
    #     end
    # end
end
