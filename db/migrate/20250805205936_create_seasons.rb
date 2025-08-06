class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.boolean :joinable, null: false, default: true
      t.string :join_code, null: true, limit: 64, index: { unique: true }

      t.timestamps
    end
  end
end
