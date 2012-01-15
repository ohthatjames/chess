require 'chess/fen_input'
require 'support/position_matcher'

describe FenInput do
  describe ".pieces_from_fen" do
    it "returns the piece portion of the fen string" do
      FenInput.pieces_from_fen("k7/8/8/8/8/8/8/K7 w - - 5 5").should == "k7/8/8/8/8/8/8/K7"
    end
  end

  describe ".squares(fen)" do
    it "returns the positions of all the pieces on the board" do
      squares = FenInput.new("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2").squares
      squares.should match_position <<-EOF
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
end
