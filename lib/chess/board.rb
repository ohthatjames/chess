module Chess
  class Board
    RANK_COUNT = 8
    FILE_COUNT = 8

    def self.from_fen(fen)
      new(FenInput.new(fen).squares)
    end

    def initialize(squares = nil)
      @squares = squares || default_starting_position
      validate_position
    end

    def to_s
      @squares.map {|rank| rank.map {|file| file.nil? ? "." : file }.join }.join("\n")
    end

    private
    def default_starting_position
      [
        %w{r n b q k b n r},
        %w{p p p p p p p p},
        [nil] * 8,
        [nil] * 8,
        [nil] * 8,
        [nil] * 8,
        %w{P P P P P P P P},
        %w{R N B Q K B N R}
      ]
    end

    def validate_position
      if @squares.size != RANK_COUNT
        raise ArgumentError, "Board must have 8 ranks"
      elsif @squares.any? {|file| file.size != FILE_COUNT }
        raise ArgumentError, "Each rank must have 8 files"
      end
    end
  end
end
