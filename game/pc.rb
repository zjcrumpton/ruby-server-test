require 'pry'
require 'matrix'


# Create a Node class
# ---------------------
# Node objects will be spots on the board - contained in the index of a matrix/2D array
# Nodes will have a contains property variable
# Nodes by default will contain nil
# Nodes can contain "R" for red, "Y" for yellow or nil for empty
# Nodes can also contain "end" to signify the bottom
# Nodes on the top row will contain numbers to allow for player choice
# Having top row for numbers also allows us to drop from that node so that ->
# -> we can still fill the top row if all other rows are full

# Nodes will be connected with a linked list. All top edge nodes are a head node, tail node is the bottom edge

# Prompting the User
# ---------------------
# Runs display_board method
# User selects a column by choosing its associated number
# if the user does not provide a valid input (one of the row numbers) - puts "Not a valid selection. Please select a column."
# Run the prompt method again
# Otherwise pass the choice to the drop_checker method

# Dropping a Checker
# ---------------------
# if current_node.next.contains.nil? eqls true, skip to the next node
# once we find that the next contains anything, we fill the contains property with the appropriate color value
# if root.next does not contain nil, puts "This column is full!" Please select another column." Then, prompt for a new input from the user
# Check for a win everytime a valid checker is dropped

# Create a Grid class
# ---------------------
# Upon initialization, build out a board
# 7 columns 8 rows 
#   Rows - 6 for gameplay, 1 for bottom edge, one top edge for column numbers
# Grid will be held in a matrix

# Building the Board
# ---------------------
# Build using Matrix.build(8, 7) (row_count, column_count)
# Fill each index on the top row with Node.new - containing numbers 1-7 respectively
# Fill all rows in the middle with Node.new containing nil - so default 
# Fill bottom row with Node.new each containing the string "end"
# Logic - if row is a top row - add numbers, increasing by one, last top row would be 7
# Logic - elsif row is bottom row - add "end" to node.contains
# Logic - else - add a default new node

# Adding Links
# ---------------------
# for each head node (numbered nodes on the top) ->
# make the next node be the one below it, and the next node be the one below that, until node.contains == "end"
# use recursion, return if the node below isn't empty
# to target the top row, iterate on the board, use an until loop - until j(columns) == 6 j += 1 - j = 0 at beginning
# current will equal the node with i = 0 and j is incremented everytime


# Displaying the Board
# ---------------------
# To display the board, display each array index in the apprpriate shape, printing one by one for each row
# Once you hit the end of a row, print a new line
# You'll print grid[0][0].contains (example), instead of the node itself
# We want the board to see what's inside
# if grid contains a number print IE | 7 |
# if grid contains a colored checker, see what color it is and print that color checker IE | R | - look into ASCII instead of just typing a letter in
# if grid contains an end block, display \C4/
# if node contains nil, display |___|
###### All we really need to do here is display a matrix of what the nodes contain

# check_win
# ---------------------
# check_row
#   initialize a variable with an empty array for holding 
#   iterate through every node starting from 3 left of the currently dropped node
#   add any node to the array that has a matching checker to the right
#   if the next node and current node doesn't match, empty the array and continue
#   once you hit the last node return false
#   if array.length == 3 at any point return true
#
# check_column
#   initialize a variable with an empty array for holding
#   iterate through the whole column starting with the root, using our linked list
#   add any node to the array that has a matching checker below
#   if the next node and current node doesn't match, empty the array and continue
#   once you hit the last node return false
#   if array.length == 3 at any point return true
#   
# check_diag
#   same implimentation as check rows, but calculate diags by adding 1 to columns index and go one lower for row index
#   same logic applies





# Classes and Methods
# ---------------------
# class Node
#   attr_accessor :contains, :next
#   initialize: contains = nil, next = nil
# 
# class Grid
#   attr_accessor :board - for holding the current state of the board - :display - for holding the actual displayed board
#   initialize: run build_grid method
#   build_grid: builds a matrix 8 rows by 7 columns returns grid
#   add_links: add links between the nodes occupying the grid
#   display_board: display board in its current state
#
# class Player
#    attr_accessor :name, :color
#    initialize - prompts for a name with get_name, displays name & color with display_info, takes argument for the current color - will be passed to it from game class
#    get_name - prompts for a name and saves it
#    display_info - puts player name and color
#    drop_checker: drops a checker into the appropriate column,
#
# class Game
#   attr_accessor :current_color, :current player
#   initialize: Creates new players, creates a new grid, current_color = "R"
#   take_turn: runs Grid methods to play the game, runs again if game_over returns nil
#   start: later will check if you want to start a new game or continue, loads if necessary, then runs the take_turn method
#   switch_player: if @current_color == red then current_color == yellow else current color == red
#   prompt_player: asks player for a valid column choice, if given, passes that choice to drop_checker, else it prompts again, then runs switch color
#   game_over: displays the winner/returns the winner
#   check_win: checks if we've hit a win condition by running these checks, if any return true, run game_over method
#           check_row: checks current row for a win condition
#           check_column: checks current column for a win condtion
#           check_diag: checks diagonal left and diag right for a win condition
#   
# More classes will be added for saving/loading
# Add variable typing module possibly?
#main.rb will just have game = Game.new and then game.start
