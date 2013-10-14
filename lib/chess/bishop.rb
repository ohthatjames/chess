module Chess
  class Bishop < Piece
    register_as "B"

    def end_squares(from, board)
      offsets = [[1,1], [-1, -1], [1, -1], [-1, 1]]
      gather_repeated_offsets(from, board, offsets)
    end
  end
end
