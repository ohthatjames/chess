require 'chess/fen_input'
require 'support/position_matcher'

describe FenInput do
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
