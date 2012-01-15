class FenInput
  def initialize(fen)
    @fen = fen
    if pieces_from_fen =~ /([^KQRBNPkqrbnp\d\.\/])/
      raise ArgumentError, "Invalid character: #{$1}"
    end
  end

  def squares
    pieces_from_fen.split("/").map do |rank|
      rank.split('').inject([]) do |squares, file|
        if file.to_i > 0
          squares += [nil] * file.to_i
        else
          squares << file
        end
        squares
      end
    end
  end

  private
  def pieces_from_fen
    @fen.split(" ").first
  end
end
