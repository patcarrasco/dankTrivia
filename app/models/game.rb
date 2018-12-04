class Game < ActiveRecord::Base
  has_many :game_questions
  has_many :questions, through: :game_questions
end
