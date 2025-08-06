class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.belongs_to :season, null: false, foreign_key: false
      t.belongs_to :user, null: false, foreign_key: false
      t.string :code, null: false, default: "", limit: 3
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :teams, %i[season_id user_id], unique: true
    add_index :teams, %i[season_id code], unique: true
  end
end
