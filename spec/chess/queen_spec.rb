require 'spec_helper'

describe Chess::Queen do
  describe "#end_squares" do
    it "returns all the diagonal, rank and file squares to the edges of the board" do
      board = Chess::Board.from_fen("8/8/8/8/2Q5/8/8/8 w KQkq - 0 2")
      expect(Chess::Queen.new(:white)).to have_end_squares("c4", board, [
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
        "f1",
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

    it "includes squares where enemy pieces are taken, but stops on that diagonal, rank or file" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/rr6/Qr6 w KQkq - 0 2")
      expect(Chess::Queen.new(:white)).to have_end_squares("a1", board, ["b2", "a2", "b1"])
    end

    it "stops before friendly pieces" do
      board = Chess::Board.from_fen("8/8/8/8/8/8/RR6/QR6 w KQkq - 0 2")
      expect(Chess::Queen.new(:white)).to have_end_squares("a1", board, [])
    end
  end
end
