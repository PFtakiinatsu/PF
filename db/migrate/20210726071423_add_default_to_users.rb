class AddDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :point, to: 1000
  end
end
