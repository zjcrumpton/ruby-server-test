require './lib/node.rb'
describe Node do
  describe "#initialize" do
    it "adds a nil value to objects by default" do
      node = Node.new
      expect(node.contains).to eql(nil)
    end

    it "takes an argument for containing non-default contains data" do
      node = Node.new("R")
      expect(node.contains).to eql("R")
    end

    it "has a next_node property pointing to nil by default" do
      node = Node.new
      expect(node.next_node).to eql(nil)
    end

    it "takes an argument for pointing next_node at something" do
      node = Node.new
      node.next_node = Node.new("Y")
      expect(node.next_node.contains).to eql("Y")
    end

    it "acts as a linked list" do
      node = Node.new
      node.next_node = Node.new("Y", Node.new("end"))
      expect(node.next_node.next_node.contains).to eql("end")
    end
  end
end
