module Chess
  class King < Piece
    register_as "K"

    def end_squares(from, board)
      offsets = [[0,1], [0, -1], [1, 0], [-1, 0], [1, -1], [-1, 1], [1, 1], [-1, -1]]
      gather_single_offsets(from, board, offsets)
    end
  end
end
