class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :battle_details
    has_many :pokemon_skills
    has_many :skills, :through => :pokemon_skills

    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_i_id'
    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_ii_id'
    has_many :battles, class_name:'Battle',  foreign_key:'winner_id'
    has_many :battles, class_name:'Battle',  foreign_key:'current_attacker_id'
end
