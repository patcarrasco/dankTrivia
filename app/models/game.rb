class Game < ActiveRecord::Base
  has_many :game_questions
  has_many :questions, through: :game_questions


  def self.game_make_random(user_id, question_no)
    game = Game.create(user_id: user_id, question_no: question_no)
    question_ids = Array.new(question_no){rand(Question.count)}
    question_ids.each do |id|
      GameQuestion.create(game_id: game.id, question_id: id)
    end
    return game
  end

  def self.game_make_by_difficulty(user_id, question_no, difficulty)
    game = Game.create(user_id: user_id, question_no: question_no)
    q_list = Question.where(:difficulty => difficulty).sample(question_no)
    q_list.collect {|question| question.id}.each do |id|
      GameQuestion.create(game_id: game.id, question_id: id)
    end
    return game
  end

  def questions_in_current_game
    GameQuestion.all.select{|gq| gq.game_id == self}
  end

  def score
    amt_right = questions_in_current_game.collect{|gq| gq.correct?}.count(true)
    amt_right.to_f / questions_in_current_game.size
  end

  def right_answer(question_id)
    current_question.correct?
  end

  def wrong_answer(question_id)
    current_question.correct?
  end

  def current_question(current_id)
   questions_in_current_game.select{|gq| gq.id == current_id}
  end

end
