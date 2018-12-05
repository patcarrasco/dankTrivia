class User < ActiveRecord::Base
  has_many :games
  has_many :game_questions, through: :games

# YO how many questions?
  def create_game(question_no)
    self.games << Game.game_make_random(self, question_no)
  end

  def see_last_game
    self.games.last
  end

  def score_from_last_game?
    GameQuestion.all.select{|gameq| gameq.game_id = see_last_game.id}.collect do |gq|
      correct? == true
    end
  end


end


#------------------- NOTES ----------------------#
