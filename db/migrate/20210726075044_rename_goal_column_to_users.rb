class RenameGoalColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :goal, :word
  end
end
