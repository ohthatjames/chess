module Chess
  class Board
    def self.from_fen(fen)
      squares = fen.split(" ").first.
        gsub(/\//, "\n").
        gsub(/(\d)/) {|m| "." * $1.to_i}
      new(squares.strip)
    end

    def initialize(squares = nil)
      @squares = squares
    end

    def to_s
      position = @squares || <<-EOF
        rnbqkbnr
        pppppppp
        ........
        ........
        ........
        ........
        PPPPPPPP
        RNBQKBNR
      EOF
      position.strip.tr(' ', '')
    end
  end
end