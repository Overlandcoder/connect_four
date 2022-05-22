require 'pry-byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7, ' ') }
  end

  def display(num = 0)
    return if num == 6

    p grid[num]
    display(num + 1)
  end

  def place_token(number, symbol)
    column = number - 1
    row = find_available_row(column)
    grid[row][column] = symbol
  end

  def game_over?(symbol)
    game_won?(symbol) || full?
  end

  def full?
    grid.all? do |row|
      row.all? { |slot| slot == ('x' || 'o') }
    end
  end

  def game_won?(symbol)
    horizontal_win?(symbol) || vertical_win?(symbol) || diagonal_win?(symbol)
  end

  def horizontal_win?(symbol, row = 0, columns = [0, 1, 2, 3])
    grid.any? do |row|
      row.each_cons(4) do |chunk|
        return true if chunk.all? { |slot| slot == symbol }
      end
    end
  end

  def vertical_win?(symbol, column = 0, rows = [0, 1, 2, 3])
    return false if column == 7    
    return true if rows.all? { |row| grid[row][column] == symbol }

    rows.map! { |row| row += 1 }
    
    if rows == [3, 4, 5, 6]
      vertical_win?(symbol, column + 1)
    else
      vertical_win?(symbol, column, rows)
    end
  end

  def diagonal_win?(symbol)
    top_left_to_bottom_right?(symbol) || top_right_to_bottom_left?(symbol)
  end

  def top_left_to_bottom_right?(symbol, row = 0, column = 0, count = 0)
    return true if count == 4
    return if grid[row].nil?

    if grid[row][column] == symbol
      count += 1
    else
      count = 0
    end
    
    if row == 6
      row = 0
      top_left_to_bottom_right?(symbol, row + 1)
    else
      top_left_to_bottom_right?(symbol, row + 1, column + 1, count)
    end
  end

  def top_right_to_bottom_left?(symbol)

  end

  private
  
  def find_available_row(row = 5, column)
    return row if grid[row][column] != 'x' && grid[row][column] != 'o'
    return if row < 0

    find_available_row(row - 1, column)
  end
end
