module Chess
  class Piece
    attr_reader :colour

    def initialize(colour)
      @colour = colour
    end

    def self.register_as(string_representation)
      @@registered_pieces ||= {}
      raise "Already registered: '#{string_representation}'" if @@registered_pieces[string_representation.upcase]
      @@registered_pieces[string_representation.upcase] = self
      @string_representation = string_representation
    end

    def self.string_representation
      @string_representation
    end

    def self.from_string(string)
      klass = @@registered_pieces[string.upcase]
      raise "Invalid piece representation: '#{string}'" unless klass
      colour = string.ord < "a".ord ? :white : :black
      klass.new(colour)
    end

    def string_representation
      self.class.string_representation or raise "You must register this Piece"
    end

    def to_s
      colour == :white ? string_representation.upcase : string_representation.downcase
    end

    def capturing_squares(from, board)
      end_squares(from, board)
    end

    private
    def gather_repeated_offsets(from, board, offsets)
      offsets.map do |offset|
        all_squares_with_offset(from, board, offset)
      end.flatten
    end

    def gather_single_offsets(from, board, offsets)
      offsets.map do |offset|
        square = from.offset(*offset)
        next unless board.valid_square?(square)
        piece = board.piece_at(square)
        if piece.nil? || piece.colour != colour
          square
        end
      end.compact
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
