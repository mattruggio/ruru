class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.string :join_code, null: true, limit: 64, index: { unique: true }
      t.string :workflow_state, null: false, default: 'waiting_for_users'

      t.timestamps
    end
  end
end
