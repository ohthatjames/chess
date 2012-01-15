require 'spec_helper'

describe Chess::FenInput do
  describe "when initializing" do
    it "raises an argument error if the position section contains an invalid character" do
      expect {
        Chess::FenInput.new("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/XRBQKBNR w KQkq c6 0 2")
      }.to raise_error(ArgumentError, "Invalid character: X")
    end
  end

  describe "#squares" do
    it "returns the positions of all the pieces on the board" do
      squares = Chess::FenInput.new("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2").squares
      squares.should == [
        ["r", "n", "b", "q", "k", "b", "n", "r"],
        ["p", "p", nil, "p", "p", "p", "p", "p"],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, "p", nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, "P", nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        ["P", "P", "P", "P", nil, "P", "P", "P"],
        ["R", "N", "B", "Q", "K", "B", "N", "R"]
      ]
    end
  end
end
