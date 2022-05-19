require 'pry-byebug'

class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def display(num = 0)
    return if num == 6

    p board[num]
    display(num + 1)
  end

  def place_token(number, symbol)
    column = number - 1
    row = find_available_row(column)
    board[row][column] = symbol
  end

  private
  
  def find_available_row(row = 5, column)
    return row if board[row][column].nil?

    find_available_row(row - 1, column)
  end

  def slot_taken?(row, column)
    board[row][column] == ('x' || 'o')
  end
end
