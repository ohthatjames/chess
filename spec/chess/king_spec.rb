require 'spec_helper'

describe Chess::King do
  describe "#end_squares" do
    it "returns all squares on ranks or files" do
      board = Chess::Board.from_fen("8/8/8/8/2K5/8/8/8 w KQkq - 0 2")
      expect(Chess::King.new(:white)).to have_end_squares("c4", board, [
        "c5",
        "d5",
        "d4",
        "d3",
        "c3",
        "b3",
        "b4",
        "b5"
      ])
    end

    it "includes squares where enemy pieces are taken, but stops on that rank or file" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/nn6/Kn6 w KQkq - 0 2")
      expect(Chess::King.new(:white)).to have_end_squares("a1", board, ["a2", "b1", "b2"])
    end

    it "stops before friendly pieces" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/R7/KR6 w KQkq - 0 2")
      expect(Chess::Rook.new(:white)).to have_end_squares("a1", board, [])
    end
  end
end
