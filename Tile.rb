require './Board.rb'

class Tile
  attr_reader :is_bomb, :display_value

  def initialize(position, board)
    @position = position
    @is_bomb = false
    @display_value = '*'
    @board = board
  end

  def place_bomb
    @is_bomb = true
  end

  def reveal
    #will reference "is bomb" to determine next display
    #if not a bomb, will look at neighbors (neighbor bomb count)
    #change its display
  end

  def neighbors

  end

  def neighbor_bomb_count

  end


end