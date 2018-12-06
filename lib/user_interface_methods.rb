

def tty_home
  var = system "echo WELCOME TO DANK TRIVIA | lolcat -a -d 50"
  TTY::Prompt.new.select("- - - - - - - - - - - -".bold) do |menu|
    menu.choice "Login" => -> do tty_login end
    menu.choice "Create User" => -> do tty_create_user end
    menu.choice "Quick Play" => -> do tty_guest end
    menu.choice "High Scores" => -> do high_scores end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def tty_create_user
  system 'clear'
  new_name = TTY::Prompt.new.ask("Enter your name") do |q|
    q.validate(/^[a-zA-Z ]{3,20}$/, "Name must be between 3 and 20 characters")
  end
  new_username = TTY::Prompt.new.ask("Enter a Username --->") do |q|
    q.validate(/^\A[a-z0-9_]{4,9}\z$/, "Username must contain 4-9 characters of letters and / or numbers")
  end
  new_password = TTY::Prompt.new.mask("Enter a Password --->") do |q|
    q.validate(/^\A[a-z0-9_]{5,10}\z$/, "Password must be between 5-10 characters and can contain letters and numbers")
  end
  $user = User.create(name:new_name, username: new_username, password: new_password, best_harvest: 0, kernel_wallet: 0)
  tty_new_user_main_menu
end

def tty_guest
  system 'clear'
  username = "anonymous"
  password = "foenrgjnglj33"
  $user = User.find_by(username: username, password:password)
  tty_guest_main_menu
end

def tty_login
  system 'clear'
  username = TTY::Prompt.new.ask("Enter Username --->")
  password = TTY::Prompt.new.mask("Enter Password --->")
  $user = User.find_by(username: username, password:password)
  if $user == nil
    TTY::Prompt.new.say("That username or password does not exist. Please try again.")
    tty_home
  else
    tty_main_menu
  end
end

def tty_guest_main_menu
  system 'clear'
  TTY::Prompt.new.say("Welcome #{$user.name}")
  new_game
end

def tty_new_user_main_menu
  system 'clear'
  TTY::Prompt.new.select("Welcome to D A N K  t r i v i a. when youre here, #{$user.name}, youre family!") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def tty_main_menu
  system 'clear'
  TTY::Prompt.new.select("Welcome back #{$user.name}") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Check my High Score" => -> do my_high_score end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def new_game
  system 'clear'
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
  quotes = [
    "You gotta water your plants. Nobody can water them for you.",
    "I put cocoa butter all over my face and my iconic belly and my arms and legs. Why live rough? Live smooth.",
    "Congratulations. You played yourself",
    "They don't want us to win",
    "The key is to make it.",
    "They will try to close the door on you, just open it.",
    "Baby, you smart. I want you to film me taking a shower.",
    "They don’t want you to win. They don’t want you to have the No. 1 record in the country. They don’t want you to get healthy. They don’t want you to exercise. And they don’t want you to have that view."
  ]

  all_questions.each do |gq|
    system "clear"
    ask_question(gq)
    sleep(0.3)
    choice = TTY::Prompt.new.select("p r e s s   e n t e r") do |menu|
      menu.choice "next question"
      menu.choice "anotha' one 🙏"
      menu.choice "anotha' one 🙏 🔑"
      menu.choice "We da best".red.blink => -> do abort("#{quotes.sample} - DJ Khalid".red) end
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
  colorize = Lolize::Colorizer.new
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
    TTY::Prompt.new.say("Correct answer was '#{question_instance.correct_answer}'...")
  end
end

def end_screen
  $user.best_score?
  TTY::Prompt.new.ok("You obtained #{$game.score} kernels of truth. Gratz!".yellow)
  TTY::Prompt.new.ok("In other words: you got #{$game.raw_score} right.")
end

def high_scores
  system 'clear'
  high_scores_list = Game.score_list.first(5)
  # binding.pry
  table = TTY::Table.new ["Username", "Score"], high_scores_list
  puts table.render :ascii, alignments: [:center, :center], padding: [1,1]
  TTY::Prompt.new.ask("Press enter to return to main menu")
  tty_home
end

def my_high_score
  TTY::Prompt.new.say("Your best harvest was #{$user.best_harvest} kernels.")
  TTY::Prompt.new.say("Your kernel wallet currently has #{$user.kernel_wallet} kernels of truth")
  TTY::Prompt.new.ask("Press enter to return to main menu")
  tty_main_menu
end
