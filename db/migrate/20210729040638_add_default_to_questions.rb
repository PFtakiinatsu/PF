# frozen_string_literal: true

class AddDefaultToQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :point, from: nil, to: '1000'
    change_column_default :questions, :point, from: nil, to: '0'
  end
end
