class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.integer :highscore10
      t.integer :highscore20
      t.integer :highscore30
    end
  end
end
