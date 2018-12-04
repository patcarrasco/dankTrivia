require_relative '../config/environment'


starting_prompt = TTY::Prompt.new


puts "DOPE TRIVIA".cyan

opening = TTY::Prompt.new
a = opening.ask("What is your name?") do |q|
  q.required true
  q.validate /^[A-Z]+$/i
  q.modify :capitalize
end

binding.pry

puts "HELLO WORLD"
