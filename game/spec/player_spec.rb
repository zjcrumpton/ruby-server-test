require './lib/player.rb'

describe Player do
  describe "#initialize" do
    it "runs get_name" do
      expect_any_instance_of(Player).to receive(:get_name)
      player = Player.new("red")
    end

    it "takes an argument for player color" do
      player = Player.new("red")
      expect(player.color).to eql("red")
    end

    it "runs display_info" do
      expect_any_instance_of(Player).to receive(:display_info)
      player = Player.new("red")
    end
  end

  describe "#get_name" do
    it "prompts the user for their name" do
    player = Player.new("red")
    expect(player.name.nil?).to eql(false)
    end
  end

  describe "#display_info" do
    it "puts player info color" do
      player = Player.new("red")
      expect(player.display_info.class).to eql(String)
    end

    describe "#drop_checker" do
      it "returns the color of the dropped checker" do
        grid = Grid.new
        player = Player.new("Red")
        expect(player.drop_checker(grid.board[0][3])).to eql("Red")
      end

      it "drops a checker in the chosen row" do
        grid = Grid.new
        player = Player.new("Red")
        player.drop_checker(grid.board[0][3])
        expect(grid.board[6][3].contains).to eql("Red")
      end
    end
  end
end
