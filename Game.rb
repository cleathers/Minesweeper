require './Board.rb'
require 'debugger'
require 'yaml'
require 'json'

class Game

  def initialize(file = nil)
    if file != nil
      @board = YAML::load(File.open(file))
    else
      @board = Board.new(1)
      @board.make_board
      @board.seed_bombs
    end
    @time = Time.now.to_f
    self.run
  end

  def run
    puts "ENTER YOUR NAME!"
    @name = gets.chomp

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
    self.check_leader_board
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
    @elapsed_time = Time.now.to_f - @time
    puts "You win. It took you #{@elapsed_time} seconds"
  end

  def check_leader_board
    if !File.exist?('leader_board.json')
      File.open('leader_board.json', 'w') { |f| f.puts '' }
    end

    # @leader_board = File.open('leader_board.json')
    leader_hash = JSON.parse(File.read('leader_board.json'))



    slow_time = leader_hash.values.max
    if @elapsed_time < slow_time
      leader_hash[@name] = @elapsed_time
      leader_hash.delete_if {|key, value| value == slow_time }
    end

    display_leader_board(leader_hash)

    leader_hash = leader_hash.to_json
    File.open('leader_board.json', 'w') do |f|
      f.puts leader_hash
    end



  end

  def display_leader_board(leader_hash)
    puts "HIGH SCORES:\n"

    leaders_array = leader_hash.sort_by { |name, time| time }.reverse
    leaders_array.each do |leader|
      puts "Name: #{leader[0]} Time: #{leader[1]}\n"
    end

  end

end