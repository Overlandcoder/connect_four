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

Let's play Connect Four! To mark a position, enter a column number (1 to 7).

The left-most column is 1, and the right-most column is 7.

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
      prompt_player
      place_token(solicit_move)
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

  def prompt_player
    puts "#{current_player.name}, make your move:"
  end

  def solicit_move
    loop do
      move = gets.chomp.to_i
      return move if valid_move?(move)

      puts 'Invalid input, please enter a number between 1 and 7.'
    end
  end

  def valid_move?(move)
    move.is_a?(Integer) && move.between?(1, 7)
  end

  def place_token

  end
end
