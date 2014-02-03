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
      tile = @board[y_coord][x_coord]
      if !(tile.is_bomb)
        tile.place_bomb
        seeded_bombs += 1
      end
    end

  end

  DELTAS = [[-1,-1],[-1,0],[-1,1],[0,1],
            [1,1],[1,0],[1,-1],[0,-1]]
  def find_neighbors(position)

    neighbors = []
    DELTAS.each do |delta|
      neighbors << [(delta[0] + position[0]), (delta[1] + position[1])]
    end

    neighbors = neighbors.select do |neighbor|
      (neighbor[0] >= 0 && neighbor[0] < @size) && (neighbor[1] >= 0 && neighbor[1] < @size)
    end

    neighbor_tiles = []
    neighbors.each do |neighbor|
      neighbor_tile = @board[neighbor[1]][neighbor[0]]
      neighbor_tiles << neighbor_tile
    end
    neighbor_tiles
  end

  def generate_display
    # make strings
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