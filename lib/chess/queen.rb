module Chess
  class Queen < Piece
    register_as "Q"

    def end_squares(from, board)
      offsets = [[1,1], [-1, -1], [1, -1], [-1, 1], [0,1], [0, -1], [1, 0], [-1, 0]]
      gather_repeated_offsets(from, board, offsets)
    end
  end
end
