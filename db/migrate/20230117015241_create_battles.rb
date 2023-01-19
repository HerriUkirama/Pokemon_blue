class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.references :pokemon_i, null: false, foreign_key: { to_table: :pokemons } 
      t.references :pokemon_ii, null: false, foreign_key: { to_table: :pokemons }
      t.references :winner, null: true, foreign_key: { to_table: :pokemons }
      t.references :current_attacker, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :level_up, default: false
      t.references :pokemon_level_up, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :get_new_skill, default: false
      t.references :pokemon_get_new_skill, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :skills_slot_full, default: false
      t.belongs_to :skill, null: true
      t.boolean :game_over, default: false
      
      t.datetime :battle_date
      t.string :status, default: "In Battle"

      t.timestamps
    end
    # add_foreign_key :battles, :pokemons, column: :pokemon1_id
    # add_foreign_key :battles, :pokemons, column: :pokemon2_id
    # add_foreign_key :battles, :pokemons, column: :winner  
  end
end
