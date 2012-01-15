module Chess
  class Board
    def self.from_fen(fen)
      new(FenInput.new(fen).squares)
    end

    def initialize(squares = nil)
      @squares = squares || default_starting_position
    end

    def to_s
      position = @squares
      position.strip.tr(' ', '')
    end

    private
    def default_starting_position
      <<-EOF
        rnbqkbnr
        pppppppp
        ........
        ........
        ........
        ........
        PPPPPPPP
        RNBQKBNR
      EOF
    end
  end
end
