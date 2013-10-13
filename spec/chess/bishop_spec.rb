require 'spec_helper'

describe Chess::Bishop do
  describe "#end_squares" do
    it "returns all the diagonal squares to the edges of the board" do
      board = Chess::Board.from_fen("8/8/8/2B5/8/8/8/8 w KQkq - 0 2")
      expect(Chess::Bishop.new.end_squares(Chess::Square.new("c4"), board).map(&:notation)).to match_array([
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
  end
end
