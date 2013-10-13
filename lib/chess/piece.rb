module Chess
  class Piece
    attr_reader :colour

    def initialize(colour)
      @colour = colour
    end

    def self.from_string(string)
      klass = case string.downcase
        when "k" then King
        when "q" then Queen
        when "r" then Rook
        when "b" then Bishop
        when "n" then Knight
        when "p" then Pawn
        else raise "Invalid piece representation"
      end
      colour = string.ord < "a".ord ? :white : :black
      klass.new(colour)
    end

    def string_representation
      raise NotImplementedError "You must define a string representation"
    end

    def to_s
      colour == :white ? string_representation.upcase : string_representation.downcase
    end
  end
end
