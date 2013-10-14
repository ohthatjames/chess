module Chess
  class Pawn < Piece
    def string_representation
      "P"
    end

    def end_squares(from, board)
      direction = colour == :white ? 1 : -1
      squares = []
      square = from.offset(0, direction)
      squares << square unless board.piece_at(square)
      if (from.rank == 1 && colour == :white) || from.rank == 6
        if board.piece_at(from.offset(0, direction)).nil? && board.piece_at(from.offset(0, direction * 2)).nil?
          squares << from.offset(0, direction * 2)
        end
      end
      squares += gather_capturing_offsets(from, board, [[1, direction], [-1, direction]])
      squares
    end

    def gather_capturing_offsets(from, board, offsets)
      offsets.map do |offset|
        square = from.offset(*offset)
        next unless board.valid_square?(square)
        piece = board.piece_at(square)
        if piece && piece.colour != colour
          square
        end
      end.compact
    end
  end
end
