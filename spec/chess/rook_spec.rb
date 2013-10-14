require 'spec_helper'

describe Chess::Rook do
  describe "#end_squares" do
    it "returns all squares on ranks or files" do
      board = Chess::Board.from_fen("8/8/8/8/2R5/8/8/8 w KQkq - 0 2")
      expect(Chess::Rook.new(:white).end_squares(Chess::Square.new("c4"), board).map(&:notation)).to match_array([
        # W
        "b4",
        "a4",
        # E
        "d4",
        "e4",
        "f4",
        "g4",
        "h4",
        # N
        "c5",
        "c6",
        "c7",
        "c8",
        # S
        "c3",
        "c2",
        "c1"
      ])
    end

    it "includes squares where enemy pieces are taken, but stops on that rank or file" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/r7/Rr6 w KQkq - 0 2")
      expect(Chess::Rook.new(:white).end_squares(Chess::Square.new("a1"), board).map(&:notation)).to match_array(["a2", "b1"])
    end

    it "stops before friendly pieces" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/R7/RR6 w KQkq - 0 2")
      expect(Chess::Rook.new(:white).end_squares(Chess::Square.new("a1"), board).map(&:notation)).to match_array([])
    end
  end
end
