require 'spec_helper'

describe Chess::Game do
  describe "in its default state" do
    context "in the default state" do
      it "has the pieces in the default setup" do
        Chess::Game.default.board.should match_position <<-EOF
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

    it "starts with white as the player to move" do
      Chess::Game.default.player_to_move.should == :white
    end
  end

  context ".from_fen" do
    subject { Chess::Game.from_fen("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2") }
    it "creates a board with the pieces in the positions specified" do
      subject.board.should match_position <<-EOF
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

    its(:player_to_move) { should == :white }
  end

  describe "#move" do
    subject { Chess::Game.new(board, :white) }

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
      subject.move(Chess::Square.new("a8"), Chess::Square.new("a7"))
      subject.board.should match_position <<-EOF
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
      subject.move(Chess::Square.new("a8"), Chess::Square.new("a7"))
      subject.player_to_move.should == :black
      subject.move(Chess::Square.new("c1"), Chess::Square.new("c2"))
      subject.player_to_move.should == :white
    end

    it "will replace the piece with the passed in promotion piece" do
      subject.move(Chess::Square.new("g7"), Chess::Square.new("g8"), Chess::Queen.new(:white))
      subject.board.should match_position <<-EOF
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
