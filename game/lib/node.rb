# frozen_string_literal: true

require 'pry'

# represents a single space on the Connect 4 Grid
class Node
  attr_accessor :contains, :next_node, :location
  def initialize(contains = nil, location = nil)
    @contains = contains
    @location = location
    @next_node = nil
  end
end
