require "chess/version"
require 'chess/board'
require 'chess/fen_input'
require 'chess/game'
require 'chess/square'
require 'chess/piece'
require 'chess/king'
require 'chess/queen'
require 'chess/rook'
require 'chess/bishop'
require 'chess/knight'
require 'chess/pawn'

module Chess
  # Base class for all chess exceptions
  class Exception < Exception;end
  class InvalidMove < Chess::Exception;end
end
