class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.belongs_to :pokedex
      t.string :name
      t.integer :pokemon_hp
      t.integer :pokemon_max_hp
      t.integer :pokemon_attack
      t.integer :pokemon_defence
      t.integer :pokemon_speed
      t.integer :pokemon_special
      t.integer :level, default: 1
      t.integer :pokemon_max_exp
      t.integer :pokemon_exp, default: 0
      t.string :status, default: "Free"

      t.timestamps
    end
  end
end
