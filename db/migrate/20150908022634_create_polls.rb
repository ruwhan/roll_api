class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :polls, :user_id
  end
end
