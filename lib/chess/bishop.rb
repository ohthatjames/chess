module Chess
  class Bishop
    def end_squares(from, board)
      offsets = [[1,1], [-1, -1], [1, -1], [-1, 1]]
      offsets.map do |offset|
        all_squares_with_offset(from, board, offset)
      end.flatten
    end

    private
    def all_squares_with_offset(from, board, offset)
      end_squares = []
      square = from.offset(*offset)
      while board.valid_square?(square)
        end_squares << square
        if board.piece_at(square)
          return end_squares
        end
        square = square.offset(*offset)
      end
      end_squares
    end
  end
end
