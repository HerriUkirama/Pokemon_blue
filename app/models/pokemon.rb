class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :battle_details
    has_many :pokemon_skills
    has_many :skills, :through => :pokemon_skills

    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_i_id'
    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_ii_id'
    has_many :battles, class_name:'Battle',  foreign_key:'winner_id'
    has_many :battles, class_name:'Battle',  foreign_key:'current_attacker_id'

    validates :pokemon_hp, numericality: { greater_than_or_equal_to: 0 }

    validate :pokedex_not_nil_validation, on: :create


    def pokedex_not_nil_validation
        puts pokedex_id
        if pokedex_id == 0
            errors.add(:pokedex_id, "must exist")
        end
    end
end
