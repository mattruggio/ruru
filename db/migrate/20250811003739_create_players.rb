class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.belongs_to :season, null: false, foreign_key: false, index: false
      t.string :code, null: false, limit: 20
      t.string :first_name, null: false, default: "", limit: 100
      t.string :last_name, null: false, default: "", limit: 100
      t.integer :position, null: false
      t.integer :overall, null: false, default: 0
      t.belongs_to :team, null: true, foreign_key: false, index: true

      t.timestamps
    end

    add_index :players, %i[season_id code], unique: true
  end
end
