class Skill < ApplicationRecord
    has_many :initiate_skills
    has_many :pokedexes, :through => :initiate_skills
end
