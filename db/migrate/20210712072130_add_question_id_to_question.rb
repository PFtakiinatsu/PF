# frozen_string_literal: true

class AddQuestionIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :question_status, :boolean, default: false, null: false
  end
end
