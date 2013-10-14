module Chess
  class Rook < Piece
    register_as "R"

    def end_squares(from, board)
      offsets = [[0,1], [0, -1], [1, 0], [-1, 0]]
      gather_repeated_offsets(from, board, offsets)
    end
  end
end
