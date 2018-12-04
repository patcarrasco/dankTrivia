class Game < ActiveRecord::Base
  has_many :game_questions
  has_many :questions, through: :game_questions

  def game_maker
    Question.all.sample(1)
  end


end
