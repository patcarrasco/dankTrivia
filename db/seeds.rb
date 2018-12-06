easy1 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy2 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy3 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy4 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy5 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy6 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy7 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy8 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy9 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy10 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy11 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy12 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy13 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy14 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy15 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy16 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
easy17 = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
moderate1 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate2 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate3 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate4 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate5 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate6 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate7 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate8 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate9 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate10 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate11 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate12 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate13 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate14 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate15 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
moderate16 = "https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple"
hard = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard1 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard2 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard3 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard4 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard5 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard6 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard7 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard8 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard9 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard10 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard11 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard12 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard13 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard14 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard15 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
hard16 = "https://opentdb.com/api.php?amount=50&difficulty=hard&type=multiple"
questions = [
  easy1, easy2,
  easy3, easy4,
  easy5, easy6,
  easy6, easy7,
  easy8, easy9,
  easy10, easy11,
  easy12, easy13,
  easy14, easy15,
  easy16, easy17,
  moderate1, moderate2,
   moderate3, moderate4,
   moderate5, moderate6,
   moderate7, moderate8,
   moderate9, moderate10,
    moderate11, moderate12,
    moderate13, moderate14,
     moderate15, moderate16,
   hard, hard1, hard2,
   hard3, hard4, hard5,
   hard6, hard7, hard8,
   hard9, hard10, hard11,
   hard12, hard13, hard14,
   hard15, hard16]

hash_enabled_questions = convert_key_to_symbol(questions)


formatted_questions = hash_enabled_questions.map do |question|
  question[:question] = HTMLEntities.new.decode question[:question]
  question[:correct_answer] = HTMLEntities.new.decode question[:correct_answer]
  question[:option1] = HTMLEntities.new.decode question[:option1]
  question[:option2] = HTMLEntities.new.decode question[:option2]
  question[:option3] = HTMLEntities.new.decode question[:option3]
  question
end
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

create_many_questions(formatted_questions)

# CREATE USERS

pat = User.create(name: "Pat Carrasco", username: "chichi", password: "password", best_harvest: 0, kernel_wallet: 0)
steve = User.create(name: "Stephen Argentina", username: "steve", password: "password", best_harvest: 0, kernel_wallet: 0)
guest = User.create(name: "Fast Boi🦔", username: "anonymous", password: "foenrgjnglj33", best_harvest: 0, kernel_wallet: 0)
