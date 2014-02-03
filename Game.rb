require './Board.rb'

class Game

  def initialize
    @board = Board.new
  end

  def run

  end

  def get_user_input
    puts "R or F, x coordinate, y coordinate (e.g.: r, 0, 0)"
    input = gets.chomp
    input.split(", ")

    action = input[0]
    coordinates = input[-2..-1]
  end


end