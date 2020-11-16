require './lib/grid.rb'

describe Grid do
  describe "#initialize" do
    it "creates an array" do
      grid = Grid.new
      expect(grid.board.class).to eql(Array)
    end
  end

  describe "#build_grid" do
    it "populates top row with nodes containing numbers 1-7" do
      grid = Grid.new
      expect(grid.board[0][1].contains).to eql(1)
    end

    it "populates middle rows with empty nodes" do
      grid = Grid.new
      expect(grid.board[4][4].contains).to eql(nil)
    end

    it "populates bottom row with nodes containing string: 'end'" do
      grid = Grid.new
      expect(grid.board[7][3].contains).to eql("end")
    end
  end

  describe "#add_links" do
    it "creates a linked list type structure" do
      grid = Grid.new
      grid.add_links
      expect(grid.board[0][0].next_node).not_to eql(nil)
    end

    it "acts on the entire top row of the board" do
      grid = Grid.new
      grid.add_links
      expect(grid.board[0][6].next_node).not_to eql(nil)
    end
  end
end
