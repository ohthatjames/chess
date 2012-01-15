module Chess
  class Board
    def self.from_fen(fen)
      new(FenInput.new(fen).squares)
    end

    def self.array_to_string(array)
      array.map {|rank| rank.map {|file| file.nil? ? "." : file }.join }.join("\n")
    end

    def initialize(squares = nil)
      @squares = squares || default_starting_position
    end

    def to_s
      @squares.strip.tr(' ', '')
    end

    private
    def default_starting_position
      Board.array_to_string([
        %w{r n b q k b n r},
        %w{p p p p p p p p},
        [nil] * 8,
        [nil] * 8,
        [nil] * 8,
        [nil] * 8,
        %w{P P P P P P P P},
        %w{R N B Q K B N R}
      ])
    end
  end
end
