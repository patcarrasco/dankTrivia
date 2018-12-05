class Question < ActiveRecord::Base
  has_many :game_questions
  has_many :games, through: :game_questions


  # def self.question_list_by_difficulty(difficulty, num)
  #   self.where(difficulty: difficulty).random(num)
  # end


end
