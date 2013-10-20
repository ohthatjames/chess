module Chess
  class Pawn < Piece
    register_as "P"

    def end_squares(from, board)
      squares = forward_moves(from, board)
      squares += capturing_squares(from, board)
      squares
    end

    def capturing_squares(from, board)
      gather_capturing_offsets(from, board, [[1, direction], [-1, direction]])
    end

    private
    def forward_moves(from, board)
      squares = []
      (1..max_squares_forward(colour, from.rank)).each do |offset|
        square = from.offset(0, direction * offset)
        if board.piece_at(square)
          return squares
        else
          squares << square
        end
      end
      squares
    end

    def direction
      colour == :white ? 1 : -1
    end

    def max_squares_forward(colour, rank)
      if (rank == 1 && colour == :white) || rank == 6
        2
      else
        1
      end
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
