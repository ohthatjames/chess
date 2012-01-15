class FenInput
  def initialize(fen)
    @fen = fen
  end

  def squares
    pieces_from_fen.
      gsub(/\//, "\n").
      gsub(/(\d)/) {|m| "." * $1.to_i}
  end

  private
  def pieces_from_fen
    @fen.split(" ").first
  end
end
