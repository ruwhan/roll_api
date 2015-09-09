class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :poll_id
      t.integer :choice_id

      t.timestamps null: false
    end

    add_index :histories, :user_id
  end
end
