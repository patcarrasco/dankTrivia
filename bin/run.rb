require_relative '../config/environment'
# require 'lolize/auto'

# Catpix::print_image "pokemon.png",
#   :limit_x => 1.0,
#   :limit_y => 0,
#   :center_x => true,
#   :center_y => true,
#   :bg => "white",
#   :bg_fill => true,
#   :resolution => "low"

options = {
  buffer_size: 2000,
  is_looping: true
}

# $audio = AudioPlayback.play("audio/love.ogg", options)

# def audio_p(var)
#   if var
#     $audio
#   else
#     $audio = nil
#     $audio
#   end
# end

AudioPlayback.play("audio/love.ogg", options)

def run_game
  system "clear"
  tty_home
  play_game
end

system "echo ...........loading the dankest of questions | lolcat"
# audio_p(true)
done = false
until done
  run_game
  TTY::Prompt.new.select("Would you like to play again?") do |menu|
    menu.choice "Sure"
    menu.choice "Fo sure"
    menu.choice "Abso-freaking-lutely"
    menu.choice "No. I am a wimp.".light_magenta => -> do done = true end
  end
end
