module Chess
  class King < Piece
    def string_representation
      "K"
    end

    def end_squares(from, board)
      offsets = [[0,1], [0, -1], [1, 0], [-1, 0], [1, -1], [-1, 1], [1, 1], [-1, -1]]
      gather_single_offsets(from, board, offsets)
    end
  end
end
