module Chess
  class Board
    RANK_COUNT = 8
    FILE_COUNT = 8

    def self.from_fen(fen)
      fen_input = FenInput.new(fen)
      new(fen_input.squares)
    end

    def self.default
      new([
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

    def initialize(squares)
      @squares = squares.map {|rank| rank.map {|file| file.is_a?(String) ? Piece.from_string(file) : file}}
      validate_position
    end

    def to_s
      @squares.map {|rank| rank.map {|file| file.nil? ? "." : file }.join }.join("\n")
    end

    def move(from, to, promotion_piece = nil)
      board = Board.new(@squares)
      piece = board.piece_at(from)
      board.set_piece_at(from, nil)
      board.set_piece_at(to, promotion_piece || piece)
      board
    end

    def valid_square?(square)
      square.rank >= 0 &&
      square.rank < RANK_COUNT &&
      square.file >= 0 &&
      square.file < FILE_COUNT
    end

    def piece_at(square)
      @squares[RANK_COUNT - square.rank - 1][square.file]
    end

    def squares_with_piece(piece_type, colour)
      each_square.with_object([]) do |(square, piece), piece_squares|
        if piece.is_a?(piece_type) && piece.colour == colour
          piece_squares << square
        end
      end
    end

    def square_being_attacked?(square, colour)
      each_square.any? do |from_square, piece|
        piece && piece.colour == colour && piece.capturing_squares(from_square, self).include?(square)
      end
    end

    def all_moves(colour)
      each_square.with_object([]) do |(square, piece), moves|
        if piece && piece.colour == colour
          piece.end_squares(square, self).each do |to_square|
            moves << [square, to_square]
          end
        end
      end
    end

    protected

    def set_piece_at(square, piece)
      @squares[RANK_COUNT - square.rank - 1][square.file] = piece
    end

    private
    def each_square
      @squares.map.with_index do |rank, rank_index|
        rank.map.with_index do |piece, file_index|
          square = Square.new(file_index, RANK_COUNT - rank_index - 1)
          [square, piece]
        end
      end.flatten(1).each
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
