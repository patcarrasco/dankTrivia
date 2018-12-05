# require_relative '../config/environment'
# prompt = TTY::Prompt
# #
# # Catpix::print_image "img/shibe.jpg",
# #   :limit_x => 1.0,
# #   :limit_y => 0,
# #   :center_x => true,
# #   :center_y => true,
# #   :bg => "white",
# #   :bg_fill => true,
# #   :resolution => "high"
#
# welcome = prompt.new
# welcome.say("NAMETBD TRIVIA")
#
#
#
# choices = ["Returning User", "Create Account"]
# ask_user_if_new = prompt.new
#
# user_true = ask_user_if_new.select("WELCOME TO TRIVIA", choices)
#
#
#
#
#
#
#
# ask_user = prompt.new
# user = ask_user.ask("Enter Username") do |q|
#   q.required true
#   q.validate /^\S+$/
#   q.modify :capitalize
# end
#
# ask_pass = prompt.new
# password = ask_pass("Enter Password", echo: false) do |q|
#   q.required true
# end
#
#
# binding.pry
#
# puts "HELLO WORLD"
