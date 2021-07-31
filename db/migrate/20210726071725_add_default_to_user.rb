# frozen_string_literal: true

class AddDefaultToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :point, from: nil, to: '1000'
  end
end
