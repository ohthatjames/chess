module Chess
  class Knight < Piece
    register_as "N"

    def end_squares(from, board)
      offsets = [[1,2], [1,-2], [-1, 2], [-1, -2], [-2, -1], [-2, 1], [2, 1], [2, -1]]
      gather_single_offsets(from, board, offsets)
    end
  end
end
