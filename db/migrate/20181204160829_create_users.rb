class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.integer :highscore_percent
      t.integer :highscore_game_id
    end
  end
end
