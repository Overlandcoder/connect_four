class Board
  attr_reader :board

  def initialize
    create_board
  end

  def create
    @board = Array.new(6, Array.new(7))
  end

  def display(num = 0)
    return if num == 6

    board[num].each_index { |i| board[num][i] = "a" }
    p board[num].join(' | ')
    puts '---------------------------'
    display_board(num + 1)
  end
end