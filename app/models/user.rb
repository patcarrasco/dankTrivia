class User < ActiveRecord::Base
  has_many :games
  has_many :game_questions, through: :games
end
