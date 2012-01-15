class FenInput
  def initialize(fen)
    @fen = fen
  end

  def squares
    FenInput.pieces_from_fen(@fen).
      gsub(/\//, "\n").
      gsub(/(\d)/) {|m| "." * $1.to_i}
  end

  def self.pieces_from_fen(fen)
    fen.split(" ").first
  end
end
