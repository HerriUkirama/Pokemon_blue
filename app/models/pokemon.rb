class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :pokemon_skills
    has_many :skills, :through => :pokemon_skills
end
