class User < ActiveRecord::Base
  has_many :games
  has_many :game_questions, through: :games

# YO how many questions?
  def create_game(question_no)
    self.games << Game.game_make_random(self, question_no)
  end

  def create_game_by_difficulty(question_no, difficulty)
    self.games << Game.game_make_by_difficulty(self, question_no, difficulty)
  end

  def see_last_game
    self.games.last
  end

  def score_from_last_game?
    GameQuestion.all.select{|gameq| gameq.game_id = see_last_game.id}.collect do |gq|
      correct? == true
    end
  end

  def best_score?
    if self.see_last_game.score > self.best_harvest
      self.update(best_harvest: self.see_last_game.score)
    end
    self.update(kernel_wallet: (self.kernel_wallet += self.see_last_game.score))
  end

end


#------------------- NOTES ----------------------#
