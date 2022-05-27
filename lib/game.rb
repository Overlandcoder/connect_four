require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player1, :player2, :positions, :board, :current_player

  SYMBOLS = ['⚫', '⚪']

  def initialize
    @board = Board.new
  end

  def setup
    intro_message
    board.display
    @player1 = create_player(1)
    @player2 = create_player(2)
    randomize_first_turn
  end

  def intro_message
    intro = <<-MESSAGE

Let's play Connect Four!

The first player to connect 4 pieces consecutively (horizontally, vertically or diagonally) wins.

To place a piece, enter a column number (1 to 7).
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
  end

  def play_game
    setup

    until board.game_over?(current_player.symbol)
      @current_player = switch_turns
      play_round
    end
    conclusion
  end

  def play_round
    prompt_player
    move = solicit_move
    board.place_token(move, current_player.symbol)
    board.display
  end

  def switch_turns
    current_player == player1 ? player2 : player1
  end

  def prompt_player
    puts "\n#{current_player.name}, make your move:"
  end

  def solicit_move
    loop do
      move = gets.chomp.to_i
      return move if valid_move?(move)

      puts 'Invalid input, please choose an empty column between 1 and 7.'
    end
  end

  def valid_move?(move)
    move.is_a?(Integer) && move.between?(1, 7) && board.grid[0][move - 1] == '  '
  end

  def conclusion
    puts "\n#{current_player.name} wins!" if board.game_won?(current_player.symbol)
    puts 'Tie game.' if board.full?
  end
end
