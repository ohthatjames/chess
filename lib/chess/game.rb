module Chess
  class Game
    attr_reader :board, :player_to_move

    def self.from_fen(fen)
      fen_input = FenInput.new(fen)
      new(Board.new(fen_input.squares), fen_input.player_to_move)
    end

    def self.default
      new(Board.default, :white)
    end

    def initialize(board, player_to_move)
      @board, @player_to_move = board, player_to_move
    end

    def move(from, to, promotion_piece=nil)
      raise InvalidMove unless valid_move?(from, to)
      @board = board.move(from, to, promotion_piece)
      change_player
    end

    private
    def valid_move?(from, to)
      piece = board.piece_at(from)
      return !piece.nil? &&
        piece.colour == player_to_move &&
        piece.end_squares(from, @board).include?(to)
    end

    def change_player
      @player_to_move = @player_to_move == :white ? :black : :white
    end
  end
end
