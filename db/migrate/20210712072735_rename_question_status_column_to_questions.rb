class RenameQuestionStatusColumnToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question_status, :is_solved
  end
end
