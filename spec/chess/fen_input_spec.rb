require 'chess/fen_input'

describe FenInput do
  describe ".pieces_from_fen" do
    it "returns the piece portion of the fen string" do
      FenInput.pieces_from_fen("k7/8/8/8/8/8/8/K7 w - - 5 5").should == "k7/8/8/8/8/8/8/K7"
    end
  end
end
