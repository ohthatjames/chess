require 'spec_helper'


TEST_BOARD_ARRAY = [
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil]]

describe Chess::Board do
  context "in the default state" do
    it "has the pieces in the default setup" do
      Chess::Board.default.should match_position <<-EOF
        rnbqkbnr
        pppppppp
        ........
        ........
        ........
        ........
        PPPPPPPP
        RNBQKBNR
      EOF
    end

    it "starts with white's move" do
      Chess::Board.default.player_to_move.should == :white
    end
  end

  context ".from_fen" do
    let(:board) { Chess::Board.from_fen("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2") }
    it "creates a board with the pieces in the positions specified" do
      board.should match_position <<-EOF
        rnbqkbnr
        pp.ppppp
        ........
        ..p.....
        ....P...
        ........
        PPPP.PPP
        RNBQKBNR
      EOF
    end
  end

  describe "#initialize" do
    it "takes a position as an array" do
      board = Chess::Board.new(TEST_BOARD_ARRAY, :white)
      board.should match_position <<-EOF
        K.......
        ........
        ........
        ........
        ........
        ........
        ........
        ..k.....
      EOF
    end

    it "takes whose turn it is" do
      board = Chess::Board.new(TEST_BOARD_ARRAY, :black)
      board.player_to_move.should == :black
    end

    let(:default_squares) { [[nil] * Chess::Board::FILE_COUNT] * Chess::Board::RANK_COUNT }

    it "raises an error if the board has less than 8 ranks" do
      expect { Chess::Board.new(default_squares.tap(&:pop)) }.to raise_error(ArgumentError)
    end

    it "raises an error if the board has more than 8 ranks" do
      expect { Chess::Board.new(default_squares.tap {|s| s << ([nil] * 8)}) }.to raise_error(ArgumentError)
    end

    it "raises an error if the board has a rank with more than 8 files" do
      Chess::Board::RANK_COUNT.times do |i|
        squares = default_squares
        squares[i] << nil
        expect { Chess::Board.new(squares) }.to raise_error(ArgumentError)
      end
    end

    it "raises an error if the board has a rank with more than 8 files" do
      Chess::Board::RANK_COUNT.times do |i|
        squares = default_squares
        squares[i].pop
        expect { Chess::Board.new(squares) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#move" do
    let(:board) do
      Chess::Board.new([
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil]
      ], :white)
    end

    it "moves the piece from the square it's on to the new square" do
      board.move(Chess::Square.new("a8"), Chess::Square.new("a7"))
      board.should match_position <<-EOF
        ........
        K.....P.
        ........
        ........
        ........
        ........
        ........
        ..k.....
      EOF
    end

    it "makes it the other player's turn" do
      board.move(Chess::Square.new("a8"), Chess::Square.new("a7"))
      board.player_to_move.should == :black
      board.move(Chess::Square.new("c1"), Chess::Square.new("c2"))
      board.player_to_move.should == :white
    end

    it "will replace the piece with the passed in promotion piece" do
      board.move(Chess::Square.new("g7"), Chess::Square.new("g8"), "Q")
      board.should match_position <<-EOF
        K.....Q.
        ........
        ........
        ........
        ........
        ........
        ........
        ..k.....
      EOF
    end
  end
end
