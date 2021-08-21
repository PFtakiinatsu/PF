class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
     add_column :questions, :question_status, :boolean, default: false, null: false
     add_column :users, :confirmation_token, :string
     add_column :users, :confirmed_at, :datetime
     add_column :users, :confirmation_sent_at, :datetime
     add_column :users, :unconfirmed_email, :string #only if using reconfirmable
  end
end
