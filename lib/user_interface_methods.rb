def tty_home
  TTY::Prompt.new.say("DANK TRIVIA")
  choice_answer = TTY::Prompt.new.select("WELCOME TO TRIVIA") do |menu|
    menu.choice "Login" => -> do tty_login end
      menu.choice "Create User" => -> do tty_create_user end
      end
    end

def tty_create_user
  new_name = TTY::Prompt.new.ask("Enter your name")
  new_username = TTY::Prompt.new.ask("Enter a Username")
  new_password = TTY::Prompt.new.mask("Enter a Password")
  User.create(name:new_name, username: new_username, password: new_password)
  # tty_main_menu
end

def tty_login
  username = TTY::Prompt.new.ask("Enter Username")
  password = TTY::Prompt.new.mask("Enter Password")
  User.find_by(username: username, password:password)
end

def tty_main_menu
  TTY::Prompt.say("Welcome #{name}")
end
