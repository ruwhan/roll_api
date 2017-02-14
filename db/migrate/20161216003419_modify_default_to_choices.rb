class ModifyDefaultToChoices < ActiveRecord::Migration
  def change
    change_column :choices, :votes, :integer, :default => 0
  end
end
