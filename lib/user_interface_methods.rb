
def home_logo
  system 'clear'
  system "artii DANK TRIVIA | lolcat -s 75 -d 10"
end

def logo
  system 'clear'
  system "artii DANK TRIVIA | lolcat"
end

def tty_home
  home_logo
  system "echo '\t\t\tWelcome to Dank Trivia' | lolcat -d 10"
  system "say 'welcome to dank trivia'"
  system "echo '>< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< ><' | lolcat -a -d 10"
  TTY::Prompt.new.select("".red.bold) do |menu|
    menu.choice "Login" => -> do tty_login end
    menu.choice "Create User" => -> do tty_create_user end
    menu.choice "Quick Play" => -> do tty_guest end
    menu.choice "High Scores 🇯🇲" => -> do high_scores end
    menu.choice "Close Program".red => -> do abort("See you later dude.") end
  end
end

def tty_create_user
  logo
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
  username = "anonymous"
  password = "foenrgjnglj33"
  $user = User.find_by(username: username, password:password)
  tty_guest_main_menu
end

def tty_login
  logo
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
  new_game
end

def tty_new_user_main_menu
  logo
  TTY::Prompt.new.select("Welcome to D A N K  t r i v i a. when you're here, #{$user.name}, youre family!") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def tty_main_menu
  logo
  system "say 'yo dog, welcome back'"
  TTY::Prompt.new.select("Welcome back #{$user.name}") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Check my High Score" => -> do my_high_score end
    menu.choice "Close Program" => -> do abort("See you later dude.") end
  end
end

def new_game
  logo
  difficulty = TTY::Prompt.new.select("Choose your difficulty".cyan) do |menu|
    menu.choice "easy"
    menu.choice "medium"
    menu.choice "hard"
    menu.choice "any"
  end
  logo
  q_amount = TTY::Prompt.new.select("How many questions?".cyan) do |menu|
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
    logo
    ask_question(gq)
    sleep(0.3)
    choice = TTY::Prompt.new.select("<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>".magenta) do |menu|
      menu.choice "next question"
      menu.choice "anotha' one 🙏"
      menu.choice "anotha' one 🙏 🔑"
      menu.choice "We da best".light_red.blink => -> do
        # audio_p(false)
        quote = quotes.sample
        system "say #{quote}"
        abort("#{quote} - DJ Khalid".light_red)
      end
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
  # colorize = Lolize::Colorizer.new
  question_options = [question_instance.correct_answer,question_instance.option1,
    question_instance.option2, question_instance.option3].shuffle
  value = TTY::Prompt.new.select(question_instance.question.light_cyan) do |option|
    option.choice question_options[0]
    option.choice question_options[1]
    option.choice question_options[2]
    option.choice question_options[3]
  end
  if value == question_instance.correct_answer
    gq.update(correct?: true)
    TTY::Prompt.new.say("Correct!! Good job, goober!@!".green)
  else
    gq.update(correct?: false)
    TTY::Prompt.new.say("Wrong answer, champ!".light_yellow)
    TTY::Prompt.new.say("Correct answer was '#{question_instance.correct_answer}'...".light_red)
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
  table = TTY::Table.new ["Username", "Kernels"], high_scores_list
  puts table.render(:ascii, alignments: [:center, :center], padding: [1,1]).yellow
  TTY::Prompt.new.ask("Press enter to return to main menu")
  tty_home
end

def my_high_score
  TTY::Prompt.new.say("Your best harvest was #{$user.best_harvest} kernels.")
  TTY::Prompt.new.say("Your kernel wallet currently has #{$user.kernel_wallet} kernels of truth")
  TTY::Prompt.new.ask("Press enter to return to main menu")
  tty_main_menu
end
