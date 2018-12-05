class Question < ActiveRecord::Base
  has_many :game_questions
  has_many :games, through: :game_questions


  def self.question_list_by_difficulty(difficulty)
    all.select {|question| question.category == difficulty}
  end



end
