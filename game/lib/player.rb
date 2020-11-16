# frozen_string_literal: true

require './game/lib/grid'
require 'colorize'
require 'pry'

# represents players
class Player
  attr_accessor :name, :color, :last_dropped

  def initialize(color)
    @color = color
    @name = learn_name
    puts display_info
  end

  def learn_name
    print "Enter #{@color} Player Name: ".green
    gets.chomp
  end

  def display_info
    "Hi #{@name}, your checker color is #{@color}!\n\n"
  end

  def drop_checker(node)
    node = node.next_node while node.next_node.contains.nil?
    node.contains = @color
    @last_dropped = node
  end
end
