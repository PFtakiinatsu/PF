class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :status
      t.integer :subject
      t.string :image_id
      t.string :title
      t.text :body
      t.integer :point

      t.timestamps
    end
  end
end
