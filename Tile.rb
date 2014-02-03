require './Board.rb'
require 'debugger'

class Tile
  attr_reader :is_bomb, :flagged
  attr_accessor :display_value

  def initialize(position, board)
    @position = position
    @is_bomb = false
    @display_value = '*'
    @board = board
    @flagged = false
  end

  def to_s
    "position: #{@position}, display_value: #{@display_value}, \n is_bomb: #{@is_bomb}, flagged: #{@flagged}"
  end

  def place_bomb
    @is_bomb = true
  end

  def reveal
    #will reference "is bomb" to determine next display
    #if not a bomb, will look at neighbors (neighbor bomb count)
    #change its display
    if self.is_bomb == true
      self.display_value = 'B'
    elsif self.neighbor_bomb_count > 0
      self.display_value = neighbor_bomb_count.to_s
    else
      self.display_value = '_'
    end

    neighbor_tiles = self.neighbors

    neighbor_tiles.each do |neighbor|
       if neighbor.neighbor_bomb_count == 0
         neighbor.reveal if self.reveal?(neighbor)
       else
         neighbor.display_value = neighbor.neighbor_bomb_count.to_s
       end
    end

  end


  def reveal?(tile)
    #bomb == true
    if tile.is_bomb == false && tile.display_value == '*' && tile.flagged == false

        return true

    end
    false
  end

  def neighbors
    @board.find_neighbors(@position)
  end

  def neighbor_bomb_count
    bomb_count = 0
    self.neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.is_bomb
    end
    bomb_count
  end


end