def tty_home
  TTY::Prompt.new.say("DANK TRIVIA")
  TTY::Prompt.new.select("WELCOME TO TRIVIA") do |menu|
    menu.choice "Login" => -> do tty_login end
    menu.choice "Create User" => -> do tty_create_user end
  end
end

def tty_create_user
  new_name = TTY::Prompt.new.ask("Enter your name")
  new_username = TTY::Prompt.new.ask("Enter a Username")
  new_password = TTY::Prompt.new.mask("Enter a Password")
  $user = User.create(name:new_name, username: new_username, password: new_password)
  # tty_main_menu
  TTY::Prompt.new.say("Welcome to Dank Trivia, #{$user.name}")
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

def tty_main_menu
  TTY::Prompt.new.select("Welcome back #{$user.name}") do |menu|
    menu.choice "Play New Game" => -> do new_game end
    menu.choice "Check High Score" #=> -> do end
    menu.choice "Check Previous Games" #=> -> do end
    menu.choice "Close Program" #=> -> do end
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
