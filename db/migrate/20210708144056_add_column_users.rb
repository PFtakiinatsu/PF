class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :goal, :string
    add_column :users, :introduction, :text
    add_column :users, :point, :integer
  end
end
