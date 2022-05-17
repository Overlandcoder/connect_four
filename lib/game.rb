require_relative 'player'

class Game
  attr_reader :player1

  SYMBOLS = ['⚫', '⚪']

  def setup
    intro_message
    @player1 = create_player(1)
    @player2 = create_player(2)
    randomize_first_turn
  end

  def intro_message
    puts "Let's play Connect Four! We'll begin by having each player choose a name."
  end

  def create_player(number)
    puts "Player #{number}, enter your name:"
    name = gets.chomp
    symbol = SYMBOLS[number - 1]
    Player.new(name, symbol)
  end

  def randomize_first_turn
    @current_player = [@player1, @player2].sample
  end

  def play_game
    setup
  end
end
