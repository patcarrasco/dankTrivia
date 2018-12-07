require_relative '../config/environment'

song = ['audio/love.ogg', 'audio/barney.ogg', 'audio/metallica.ogg', 'audio/nevergunna.ogg',
        'audio/redstheme.ogg','audio/silverbells.ogg', 'audio/tetristheme.ogg']
options = {
  buffer_size: 50000,
  is_looping: true
}


# def audio_p(var)
#   if var
#     $audio
#   else
#     $audio = nil
#     $audio
#   end
# end

AudioPlayback.play("#{song.sample}", options)

def run_game
  system "clear"
  tty_home
  play_again?
end

system "echo ...........loading the dankest of questions | lolcat"
# audio_p(true)
done = false
until done
  run_game
  done = true
end
