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
      board = Chess::Board.new(TEST_BOARD_ARRAY)
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
      ])
    end

    it "moves the piece from the square it's on to the new square" do
      new_board = board.move(Chess::Square.new("a8"), Chess::Square.new("a7"))
      new_board.should match_position <<-EOF
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

    it "will replace the piece with the passed in promotion piece" do
      new_board = board.move(Chess::Square.new("g7"), Chess::Square.new("g8"), Chess::Queen.new(:white))
      new_board.should match_position <<-EOF
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

  describe "#squares_with_piece" do
    subject { Chess::Board.default }

    it "returns the squares with the given piece on it" do
      subject.squares_with_piece(Chess::King, :white).should == [Chess::Square.new("e1")]
      subject.squares_with_piece(Chess::King, :black).should == [Chess::Square.new("e8")]
      subject.squares_with_piece(Chess::Knight, :white).should == [Chess::Square.new("b1"), Chess::Square.new("g1")]
    end
  end

  describe "#square_being_attacked?" do
    subject { Chess::Board.default }

    it "returns false if the square isn't being attacked by the player" do
      subject.square_being_attacked?(Chess::Square.new("e5"), :white).should be_false
      subject.square_being_attacked?(Chess::Square.new("e5"), :black).should be_false
    end

    it "returns true if any pieces by the player are attacking the square" do
      subject.square_being_attacked?(Chess::Square.new("c3"), :white).should be_true
      subject.square_being_attacked?(Chess::Square.new("c3"), :black).should be_false
    end
  end
end
