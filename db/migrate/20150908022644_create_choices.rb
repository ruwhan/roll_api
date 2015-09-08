class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :label
      t.integer :votes
      t.integer :poll_id

      t.timestamps null: false
    end

    add_index :choices, :poll_id
  end
end
