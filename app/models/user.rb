class User < ActiveRecord::Base
  has_many :games
  has_many :game_questions, through: :games

# YO how many questions?
  def create_game(question_no)
    Game.create(user_id: self, question_no: question_no)
  end

  def see_all_games
    Game.all.select{|game| user_id = self}
  end

  def see_last_game
    see_all_games.last
  end

  def score_from_last_game?
    see_last_game
  end
end
