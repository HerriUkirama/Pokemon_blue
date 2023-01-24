class Pokemon < ApplicationRecord
    # before_destroy :destroy_battle

    belongs_to :pokedex
    has_many :battle_details
    has_many :pokemon_skills ,dependent: :destroy
    has_many :skills, :through => :pokemon_skills

    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_i_id'
    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_ii_id'
    has_many :battles, class_name:'Battle',  foreign_key:'winner_id'
    has_many :battles, class_name:'Battle',  foreign_key:'current_attacker_id'

    validates :pokemon_hp, numericality: { greater_than_or_equal_to: 0 }

    validate :pokedex_not_nil_validation, on: :create
    # validate :check_pokemon_in_battle, on: :update


    private
    def pokedex_not_nil_validation
        puts pokedex_id
        if pokedex_id == 0
            errors.add(:pokedex_id, "must exist")
        end
    end
    
    # def destroy_battle
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
        
    #     battles.each do |battle|
    #         battle.destroy
    #     end
    # end
    # def check_pokemon_in_battle
    #     pokemon = Pokemon.find(self.id)
    # end
    
    # def check_pokemon_in_battle
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
    #     battles_check = battles.any? {|battle| battle.status == "In Battle"}
    #     if battles_check
    #         errors.add(:id, "Pokemon can't update because pokemon is in battle")
    #     end
    # end
    
end
