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
end
