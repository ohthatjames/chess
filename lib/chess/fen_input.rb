class FenInput
  def self.pieces_from_fen(fen)
    fen.split(" ").first
  end
end