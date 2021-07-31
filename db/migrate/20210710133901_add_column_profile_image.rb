# frozen_string_literal: true

class AddColumnProfileImage < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image, :string
  end
end
