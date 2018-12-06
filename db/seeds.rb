easy1 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy2 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
moderate1 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate2 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
hard = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard2 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"

questions = [easy1, easy2, moderate1, moderate2, hard, hard2]

new_questions = convert_key_to_symbol(questions)

puts "In SEEDS"

# CREATE QUESTIONS

def create_many_questions(array)
  array.each do |hash|
    # binding.pry
    Question.create(
      question: hash[:question],
      correct_answer: hash[:correct_answer],
      option1: hash[:option1],
      option2: hash[:option2],
      option3: hash[:option3],
      difficulty: hash[:difficulty],
      category: hash[:category])
  end
end

create_many_questions(new_questions)

# CREATE USERS

pat = User.create(name: "Pat Carrasco", username: "chichi", password: "password")
steve = User.create(name: "Stephen Argentina", username: "steve", password: "password")
guest = User.create(name: "Fast Boi🦔", username: "guest", password: "guest")

# CREATE GAMES
