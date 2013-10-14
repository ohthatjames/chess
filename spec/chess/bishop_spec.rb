require 'spec_helper'

describe Chess::Bishop do
  describe "#end_squares" do
    it "returns all the diagonal squares to the edges of the board" do
      board = Chess::Board.from_fen("8/8/8/8/2B5/8/8/8 w KQkq - 0 2")
      expect(Chess::Bishop.new(:white).end_squares(Chess::Square.new("c4"), board).map(&:notation)).to match_array([
        # SW
        "b3",
        "a2",
        # NW
        "b5",
        "a6",
        # NE
        "d5",
        "e6",
        "f7",
        "g8",
        # SE
        "d3",
        "e2",
        "f1"
      ])
    end

    it "includes squares where enemy pieces are taken, but stops on that diagonal" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/1r6/B7 w KQkq - 0 2")
      expect(Chess::Bishop.new(:white).end_squares(Chess::Square.new("a1"), board).map(&:notation)).to match_array(["b2"])
    end

    it "stops before friendly pieces" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/1R6/B7 w KQkq - 0 2")
      expect(Chess::Bishop.new(:white).end_squares(Chess::Square.new("a1"), board).map(&:notation)).to match_array([])
    end
  end
end
