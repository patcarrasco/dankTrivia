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
    last_game_id = see_last_game.id
    GameQuestion.all.select{|gameq| gameq.game_id = last_game_id}.collect{|gameq| gameq.correct?}.inject{|sum, v| sum + v}
  end
end


#------------------- NOTES ----------------------#
