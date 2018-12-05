def tty_home
  TTY::Prompt.new.select("WELCOME TO DANK TRIVIA") do |menu|
    menu.choice "Login" => -> do tty_login end
    menu.choice "Create User" => -> do tty_create_user end
    menu.choice "Quick Play" => -> do tty_guest end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def tty_create_user
  new_name = TTY::Prompt.new.ask("Enter your name")
  new_username = TTY::Prompt.new.ask("Enter a Username")
  new_password = TTY::Prompt.new.mask("Enter a Password")
  $user = User.create(name:new_name, username: new_username, password: new_password)
  tty_main_menu
  TTY::Prompt.new.say("Welcome to Dank Trivia, #{$user.name}")
end

def tty_guest
  username = "guest"
  password = "guest"
  $user = User.find_by(username: username, password:password)
  tty_guest_main_menu
end

def tty_login
  username = TTY::Prompt.new.ask("Enter Username")
  password = TTY::Prompt.new.mask("Enter Password")
  $user = User.find_by(username: username, password:password)
  if $user == nil
    TTY::Prompt.new.say("That username or password does not exist. Please try again.")
    tty_home
  else
    tty_main_menu
  end
end

def tty_guest_main_menu
  TTY::Prompt.new.say("Welcome #{$user.name}")
  new_game
end

def tty_main_menu
  TTY::Prompt.new.select("Welcome back #{$user.name}") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Check High Score" #=> -> do end
    menu.choice "Check Previous Games" #=> -> do end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def new_game
  difficulty = TTY::Prompt.new.select("Choose your difficulty") do |menu|
    menu.choice "easy"
    menu.choice "medium"
    menu.choice "hard"
    menu.choice "any"
  end
  q_amount = TTY::Prompt.new.select("How many questions?") do |menu|
    menu.choice 10
    menu.choice 20
    menu.choice 30
  end.to_i

  if difficulty == "any"
    $user.create_game(q_amount)
  else
    $user.create_game_by_difficulty(q_amount, difficulty)
  end
end

def play_game
  all_questions.each do |gq|
    system "clear"
    ask_question(gq)
    sleep(0.5)
    choice = TTY::Prompt.new.select("n e x t") do |menu|
      menu.choice "plz.."
      menu.choice "do...."
      menu.choice "not...."
      menu.choice "quit." => -> do abort("Quitter..") end
    end
  end
  end_screen
end

def all_questions
  $game = $user.games.last
  q_list = $game.questions_in_current_game
  q_list
end

def ask_question(gq)
  question_instance = Question.find(gq.question_id)
  question_options = [question_instance.correct_answer,question_instance.option1,
    question_instance.option2, question_instance.option3].shuffle
  value = TTY::Prompt.new.select(question_instance.question) do |option|
    option.choice question_options[0]
    option.choice question_options[1]
    option.choice question_options[2]
    option.choice question_options[3]
  end
  if value == question_instance.correct_answer
    gq.update(correct?: true)
    TTY::Prompt.new.say("Correct!! Good job goober!@!")
  else
    gq.update(correct?: false)
    TTY::Prompt.new.say("Wrong answer champ!")
    TTY::Prompt.new.say("Correct answer was '#{question_instance.correct_answer}'..'")
  end
end

def end_screen
  puts "You scored #{$game.score}%. Gratz!"
end

