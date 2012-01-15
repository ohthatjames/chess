require 'chess/board'
describe Chess::Board do
  context "in its initial state" do
    it "has the pieces in the default setup" do
      position = <<-EOF
        rnbqkbnr
        pppppppp
        ........
        ........
        ........
        ........
        PPPPPPPP
        RNBQKBNR
      EOF
      subject.to_s.should == position.strip.tr(' ', '')
    end
  end

  context ".from_fen" do
    it "creates a board with the pieces in the positions specified" do
      position = <<-EOF
        rnbqkbnr
        pp.ppppp
        ........
        ..p.....
        ....P...
        ........
        PPPP.PPP
        RNBQKBNR
      EOF
      board = Chess::Board.from_fen("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
      board.to_s.should == position.strip.tr(' ', '')
    end
  end
end
