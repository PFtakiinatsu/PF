# frozen_string_literal: true

class AddBestanswerIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :best_answer_id, :integer
  end
end
