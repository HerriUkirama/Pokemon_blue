class Skill < ApplicationRecord
    has_many :initiate_skills
    has_many :pokedexes, :through => :initiate_skills
    has_many :pokemon_skills, dependent: :destroy
    has_many :pokemons, :through => :pokemon_skills

    has_one :battle
end
