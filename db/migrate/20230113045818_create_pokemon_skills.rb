class CreatePokemonSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_skills do |t|

      t.timestamps
    end
  end
end
