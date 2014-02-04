require './Board.rb'
require 'debugger'
require 'yaml'

class Game

  def initialize(file = nil)
    if file != nil
      @board = YAML::load(File.open(file))
    else
      @board = Board.new(1)
      @board.make_board
      @board.seed_bombs
    end
    self.run
  end

  def run

    until self.won?
      @board.generate_display
      action, coordinates = self.get_user_input
      if action == 'r'
        if @board.board[coordinates[1]][coordinates[0]].is_bomb == true
          self.lost
          return ' '
        else
          @board.board[coordinates[1]][coordinates[0]].reveal
        end
      elsif action == 'f'
        @board.board[coordinates[1]][coordinates[0]].flag_tile
      elsif action == 's'
        yaml_board = @board.to_yaml
        File.open('yaml_board.yaml','w') do |f|
          f.puts yaml_board
        end
      else
        puts "Invalid entry"
        action, coordinates = self.get_user_input
      end

    end

    self.won
    return ' '
  end

  def get_user_input
    puts "r or f, x coordinate, y coordinate (e.g.: r, 0, 0)"
    puts "enter s to save"
    input = gets.chomp
    return input if input == 's'
    input = input.split(", ")

    action = input[0]
    coordinates = input[-2..-1]
    coordinates.map! {|item| item = item.to_i}
    [action, coordinates]
  end

  def lost
    puts "You hit a bomb, You lose"
  end

  def won?
    @board.board.each do |row|
      row.each do |tile|
       if tile.is_bomb == false && tile.revealed == false
         return false
       end
      end
    end
    true
  end

  def won
    puts "You win"
  end





end