# frozen_string_literal: true

require './game/lib/grid.rb'
require './game/lib/player.rb'
require 'colorize'

# manages the state of the game and allows the classes to interact
class Game
  attr_accessor :current_player, :players, :grid, :turn_count

  def welcome_message
    '
    ZJCrumpton Presents:

     /$$$$$$                                                /$$           /$$   /$$
    /$$__  $$                                              | $$          | $$  | $$
   | $$  \__/ /$$$$$$ /$$$$$$$ /$$$$$$$  /$$$$$$  /$$$$$$$/$$$$$$        | $$  | $$
   | $$      /$$__  $| $$__  $| $$__  $$/$$__  $$/$$_____|_  $$_/        | $$$$$$$$
   | $$     | $$  \ $| $$  \ $| $$  \ $| $$$$$$$| $$       | $$          |_____  $$
   | $$    $| $$  | $| $$  | $| $$  | $| $$_____| $$       | $$ /$$            | $$
   |  $$$$$$|  $$$$$$| $$  | $| $$  | $|  $$$$$$|  $$$$$$$ |  $$$$/            | $$
    \______/ \______/|__/  |__|__/  |__/\_______/\_______/  \___/              |__/


                                                                                   '.light_blue
  end

  def start
    @players = [Player.new('Red'), Player.new('Yellow')]
    @current_player = @players[0]
    @grid = Grid.new
    @grid.display_board
    @choices = [0, 1, 2, 3, 4, 5, 6]
    @turn_count = 0
    @winning_checkers = 0
    take_turn
  end

  def take_turn
    columns_full?
    @current_player.drop_checker(@grid.board[0][prompt_player])
    @grid.display_board
    return game_over if check_win == true

    switch_player
    take_turn
  end

  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def columns_full?
    @grid.board[0].each do |node|
      !node.next_node.contains.nil? ? @choices.delete(node.contains) : next
    end
  end

  def prompt_player
    puts "#{@current_player.name} - Please select the column where you want to drop a checker: 0-6"
    choice = gets.chomp.to_i
    @choices.include?(choice) ? (return choice.to_i) : prompt_player
  end

  def check_win
    return true if check_four(last_column) == true || check_four(last_row) == true || check_diags == true

    false
  end

  def last_row
    @grid.board[current_player.last_dropped.location[0]]
  end

  def last_column
    @grid.board.transpose[@current_player.last_dropped.location[1]]
  end

  def check_diags
    return true if check_four(last_diag) == true || check_four(last_diag(true)) == true

    false
  end

  def last_diag(reversed = false, diagonal = nil)
    padding = [*0..(@grid.board.length - 1)]
    padding = padding.reverse if reversed
    padding = padding.map { |i| [nil] * i }
    diag = padding.reverse.zip(@grid.board).zip(padding).map(&:flatten).transpose.map(&:compact).reject { |x| x.size < 5 }
    diag.each { |arr| arr.include?(@current_player.last_dropped) ? (diagonal = arr) : next }
    diagonal
  end

  def check_four(array, winning_checkers = 0)
    @winning_checkers = winning_checkers
    return false if array.nil?

    array.each do |node|
      update_winning_checkers(node)
      return true if @winning_checkers == 4
    end
  end

  def update_winning_checkers(node)
    node.contains == @current_player.color ? @winning_checkers += 1 : @winning_checkers = 0
  end

  def game_over
    puts "#{@current_player.name} is the winner!"
    true
  end

  def tie
    "It's a draw!"
  end
end
