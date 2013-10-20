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
        [nil, "Q", nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, "b", nil, nil, nil, nil],
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
        KQ....P.
        ........
        ...b....
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
        .Q......
        ........
        ...b....
        ........
        ........
        ........
        ..k.....
      EOF
    end

    it "raises an error if the move doesn't have a piece in the from square" do
      expect {
        subject.move(Chess::Square.new("g1"), Chess::Square.new("g8"))
      }.to raise_error(Chess::InvalidMove)
    end

    it "raises an error if the piece isn't for the player to move" do
      expect {
        subject.move(Chess::Square.new("c1"), Chess::Square.new("c2"))
      }.to raise_error(Chess::InvalidMove)
    end

    it "raises an error if the piece can't move to the destination square" do
      expect {
        subject.move(Chess::Square.new("g7"), Chess::Square.new("g5"))
      }.to raise_error(Chess::InvalidMove)
    end

    it "raises an error if the move leaves the King in check" do
      expect {
        subject.move(Chess::Square.new("b7"), Chess::Square.new("b6"))
      }.to raise_error(Chess::InvalidMove)
    end

    it "allows enemy pinned pieces to still count as an attacking piece" do
      board = Chess::Board.new([
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, "Q", nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, "B", nil, nil, nil],
        [nil, nil, nil, "b", nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ])
      game = Chess::Game.new(board, :white)
      expect {
        game.move(Chess::Square.new("b7"), Chess::Square.new("b6"))
      }.to raise_error(Chess::InvalidMove)
    end
  end

  describe "state" do
    it "is :play under normal play" do
      board = Chess::Board.new([
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, "Q", nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, "B", nil, nil, nil],
        [nil, nil, nil, "b", nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ])
      game = Chess::Game.new(board, :white)
      game.state.should == :play
    end

    it "is check if the current player is being attacked" do
      board = Chess::Board.new([
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, "b", nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ])
      game = Chess::Game.new(board, :white)
      game.state.should == :check
    end

    it "is check if the attacking piece is pinned" do
      board = Chess::Board.new([
        ["K", nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, "P", nil],
        [nil, nil, nil, nil, "B", nil, nil, nil],
        [nil, nil, nil, "b", nil, nil, nil, nil],
        [nil, nil, "k", nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ])
      game = Chess::Game.new(board, :white)
      game.state.should == :check
    end
  end
end
