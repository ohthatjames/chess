module Chess
  class Piece
    attr_reader :colour

    def initialize(colour)
      @colour = colour
    end

    def self.from_string(string)
      klass = case string.downcase
        when "k" then King
        when "q" then Queen
        when "r" then Rook
        when "b" then Bishop
        when "n" then Knight
        when "p" then Pawn
        else raise "Invalid piece representation"
      end
      colour = string.ord < "a".ord ? :white : :black
      klass.new(colour)
    end

    def string_representation
      raise NotImplementedError "You must define a string representation"
    end

    def to_s
      colour == :white ? string_representation.upcase : string_representation.downcase
    end

    private
    def gather_repeated_offsets(from, board, offsets)
      offsets.map do |offset|
        all_squares_with_offset(from, board, offset)
      end.flatten
    end

    def all_squares_with_offset(from, board, offset)
      end_squares = []
      square = from.offset(*offset)
      while board.valid_square?(square)
        piece = board.piece_at(square)
        if piece.nil? || piece.colour != colour
          end_squares << square
        end
        if piece
          return end_squares
        end
        square = square.offset(*offset)
      end
      end_squares
    end
  end
end
