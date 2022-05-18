class Board
  attr_reader :board

  def initialize
    @board = Array.new(6, Array.new(8))
  end

  # ignore
  def insert_numbers(i = 0)
    return if i == 6

    board[i][0] = (i + 1) * 10
    insert_numbers(i + 1)
  end

  def display(num = 0)
    return if num == 6

    board.each do |array|
      #array.each_index { |i| board[num][i] = '⚫' if i > 0 }
    end
    p board[num]
    display(num + 1)
  end
end