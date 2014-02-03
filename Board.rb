require './Tile.rb'
require 'debugger'

class Board
  attr_accessor :board
  def initialize(bombs = 10, size = 9)
    @bombs = bombs
    @size = size
  end


  def make_board
    @board = Array.new(@size) { Array.new(@size)}

    @board.each_with_index do |row, row_index|
      row.each_with_index do |tile, col_index|
        pos = [col_index, row_index]
        tile = Tile.new(pos, self)
        @board[row_index][col_index] = tile
      end
    end

  end

  def seed_bombs
    seeded_bombs = 0
    until seeded_bombs == @bombs

      y_coord = rand(9)
      x_coord = rand(9)
      tile = @board[x_coord][y_coord]
      if !(tile.is_bomb)
        tile.place_bomb
        seeded_bombs += 1
      end
    end

  end

  def find_neighbors(position)
    neighbors = []
    #fill this array with tile objects

  end

  def generate_display
    display = []

    @board.each do |row|
      display_row = []
      row.each do |tile|
        display_row << tile.display_value
      end
      display << display_row
    end
    display

  end

end