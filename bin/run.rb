require_relative '../config/environment'

song = ['audio/love.ogg', 'audio/barney.ogg', 'audio/metallica.ogg', 'audio/nevergunna.ogg',
        'audio/redstheme.ogg']

AudioPlayback.play("#{song.sample}", is_looping: true)

def run_game
  system "clear"
  tty_home
  play_again?
end

loop do
  run_game
end
