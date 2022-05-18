require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player1, :positions, :board, :current_player

  SYMBOLS = ['⚫', '⚪']

  def initialize
    @board = Board.new
  end

  def setup
    board.display
    intro_message
    @player1 = create_player(1)
    @player2 = create_player(2)
    randomize_first_turn
  end

  def intro_message
    intro = <<-MESSAGE

Let's play Connect Four! To mark a position, enter the corresponding number.

For example, enter 50 to mark the left-most position on the bottom. Or,
enter 51 to mark the position to the right of that.

We'll begin by having each player choose a name.
MESSAGE
    puts intro
  end

  def create_player(number)
    puts "\nPlayer #{number}, enter your name:"
    name = gets.chomp.capitalize
    symbol = SYMBOLS[number - 1]
    Player.new(name, symbol)
  end

  def randomize_first_turn
    @current_player = [@player1, @player2].sample
    puts "\n#{@current_player.name} will go first."
  end

  def play_game
    setup

    until game_over?
      @current_player = switch_turns
    end
  end

  def game_over?
    #game_won? || game_tied?
  end

  def game_won?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def horizontal_win?

  end

  def switch_turns
    current_player == player1 ? player2 : player1
  end

  def solicit_move
    puts "#{@current_player.name}, make your move:"
  end
end
