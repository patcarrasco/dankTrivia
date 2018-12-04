class CreateGameQuestion < ActiveRecord::Migration[5.0]
  def change
    create_table :game_questions do |t|
      t.integer :game_id
      t.integer :question_id
      t.boolean :correct?
    end
  end
end
