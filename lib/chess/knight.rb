module Chess
  class Knight < Piece
    def string_representation
      "N"
    end

    def end_squares(from, board)
      offsets = [[1,2], [1,-2], [-1, 2], [-1, -2], [-2, -1], [-2, 1], [2, 1], [2, -1]]
      gather_single_offsets(from, board, offsets)
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
  end
end
