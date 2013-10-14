require 'spec_helper'

describe Chess::Knight do
  describe "#end_squares" do
    it "returns all knight moves from the given square" do
      board = Chess::Board.from_fen("8/8/8/8/2N5/8/8/8 w KQkq - 0 2")
      expect(Chess::Knight.new(:white)).to have_end_squares("c4", board, [
        "b2",
        "a3",
        "a5",
        "b6",
        "d6",
        "e5",
        "e3",
        "d2"
      ])
    end

    it "includes squares where enemy pieces are taken" do
      board = Chess::Board.from_fen("8/8/8/8/8/1r6/2r5/N7 w KQkq - 0 2")
      expect(Chess::Knight.new(:white)).to have_end_squares("a1", board, ["c2", "b3"])
    end

    it "stops before friendly pieces" do
      board = Chess::Board.from_fen("8/8/8/8/8/1R6/2R5/N7 w KQkq - 0 2")
      expect(Chess::Knight.new(:white)).to have_end_squares("a1", board, [])
    end
  end
end
