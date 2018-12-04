class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer
      t.string :type
      t.string :option1
      t.string :option2
      t.string :option3
      t.integer :game_id
      t.string :difficulty
      t.string :category
    end
  end
end
