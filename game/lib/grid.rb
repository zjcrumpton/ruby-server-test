# frozen_string_literal: true

require './game/lib/node.rb'
require 'colorize'

# represents the game board
class Grid
  attr_accessor :board, :display

  def initialize
    build_grid
    add_links
  end

  def build_grid
    row = 0
    column = -1
    @board = Array.new(8) do
      Array.new(7) do
        column == 6 ? (row += 1; column = 0) : column += 1
        if row.zero?
          Node.new(column, [row, column])
        elsif row == 7
          Node.new('end', [row, column])
        else
          Node.new(nil, [row, column])
        end
      end
    end
  end

  def add_links
    @board[0].each do |head|
      current = head
      until current.contains == 'end'
        current.next_node = @board[current.location[0] + 1][current.location[1]]
        current = current.next_node
      end
    end
  end

  def display_board
    @board.each do |row|
      row.each do |item|
        if item.contains == 'end'
          print '====='.blue
        elsif item.contains.nil?
          print '|-o-|'.light_blue
        elsif item.contains == 'Red' || item.contains == 'Yellow'
          item.contains == 'Red' ? (print '|-o-|'.red) : (print '|-o-|'.yellow)
        else
          print "  #{item.contains}  ".green
        end
      end
      print "\n"
    end
  end
end
