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
    GameQuestion.all.select{|gq| gq.game_id == self.id}
  end

  def raw_score
    amt_right = questions_in_current_game.collect{|gq| gq.correct?}.count(true)
    value = "#{amt_right} / #{questions_in_current_game.size}"
  end


  def score
    amt_right = questions_in_current_game.select{|gq| gq.correct?}
    question_list = []
    amt_right.each{|gq| question_list << Question.find(gq.question_id)}
    points = 0
    question_list.each do |question|
      points += 175 if question.difficulty == "easy"
      points += 350 if question.difficulty == "medium"
      points += 475 if question.difficulty == "hard"
    end
    return points
  end

  def self.score_list
    high_scores = {}
    all.each do |game|
      user = User.find(game.user_id)
      high_scores[user.username] = game.score
      # bindinsg.pry
    end
    high_scores.sort_by{|k,v| v}.reverse
    # binding.pry
  end


end
