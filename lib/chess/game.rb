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

    def state
      if check?(board) && valid_moves(board.all_moves(player_to_move)).empty?
        :checkmate
      elsif check?(board)
        :check
      else
        :play
      end
    end

    def move(from, to, promotion_piece=nil)
      raise InvalidMove unless valid_move?(from, to)
      new_board = board.move(from, to, promotion_piece)
      raise InvalidMove if check?(new_board)
      @board = new_board
      change_player
    end

    private
    def check?(board)
      square_with_friendly_king = board.squares_with_piece(King, player_to_move).first
      # If there's no king, a move has removed it, so it's check
      return true if square_with_friendly_king.nil?
      board.square_being_attacked?(square_with_friendly_king, other_player)
    end

    def valid_moves(moves)
      moves.reject do |(from, to)|
        new_board = board.move(from, to)
        check?(new_board)
      end
    end

    def valid_move?(from, to)
      piece = board.piece_at(from)
      return !piece.nil? &&
        piece.colour == player_to_move &&
        piece.end_squares(from, @board).include?(to)
    end

    def change_player
      @player_to_move = other_player
    end

    def other_player
      @player_to_move == :white ? :black : :white
    end
  end
end
