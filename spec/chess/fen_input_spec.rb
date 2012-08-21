require 'spec_helper'
require 'set'

def make_fen_input(color)
  raise ArgumentError unless Set.new(["b", "w", "x"]).include? color
  "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR #{color} KQkq c6 0 2"
end

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

  describe "#player_to_move" do
    it "returns :white if the second value in the fen string is 'w'" do
      fen_input = Chess::FenInput.new(make_fen_input("w"))
      fen_input.player_to_move.should == :white
    end

    it "returns :black if the second value in the fen string is 'b'" do
      fen_input = Chess::FenInput.new(make_fen_input("b"))
      fen_input.player_to_move.should == :black
    end

    it "raises an error on any other second value" do
      fen_input = Chess::FenInput.new(make_fen_input("x"))
      expect { fen_input.player_to_move }.to raise_error(ArgumentError, "Invalid character in player to move: x")
    end
  end
end
