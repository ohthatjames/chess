require 'spec_helper'

describe Chess::Pawn do
  describe "#end_squares" do
    it "allows a move one square forward" do
      board = Chess::Board.from_fen("8/8/1p6/8/8/1P6/8/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b3", board, ["b4"])
      expect(Chess::Pawn.new(:black)).to have_end_squares("b6", board, ["b5"])
    end

    it "allows a move two forwards on the first move of that pawn" do
      board = Chess::Board.from_fen("8/1p6/8/8/8/8/1P6/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b2", board, ["b4", "b3"])
      expect(Chess::Pawn.new(:black)).to have_end_squares("b7", board, ["b6", "b5"])
    end

    it "includes diagonal captures of enemy pieces" do
      board = Chess::Board.from_fen("8/8/1p6/P1P5/p1p5/1P6/8/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b3", board, ["b4", "a4", "c4"])
      expect(Chess::Pawn.new(:black)).to have_end_squares("b6", board, ["b5", "a5", "c5"])
    end

    it "ignores friendly pieces in the capture diagonal" do
      board = Chess::Board.from_fen("8/8/1p6/p1p5/P1P5/1P6/8/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b3", board, ["b4"])
      expect(Chess::Pawn.new(:black)).to have_end_squares("b6", board, ["b5"])
    end

    it "can't capture ahead" do
      board = Chess::Board.from_fen("8/8/1p6/1p6/1p6/1P6/8/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b3", board, [])
      expect(Chess::Pawn.new(:black)).to have_end_squares("b6", board, [])
    end

    it "can't move 2 on the first go if there are pieces in either two squares ahead" do
      board = Chess::Board.from_fen("8/1p6/8/1p6/8/8/8/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:black)).to have_end_squares("b7", board, ["b6"])
      board = Chess::Board.from_fen("8/8/8/8/8/1P6/1P6/8 w KQkq - 0 2")
      expect(Chess::Pawn.new(:white)).to have_end_squares("b2", board, [])
    end
  end
end
