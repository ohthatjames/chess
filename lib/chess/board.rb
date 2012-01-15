module Chess
  class Board
    def self.from_fen(fen)
      squares = fen.split(" ").first.split('/').inject("") do |output, line|
        line.split('').each do |char|
          if char.to_i > 0
            output << "." * char.to_i
          else
            output << char
          end
        end
        output + "\n"
      end
      new(squares.strip)
    end

    def initialize(squares = nil)
      @squares = squares
    end

    def to_s
      position = @squares || <<-EOF
        rnbqkbnr
        pppppppp
        ........
        ........
        ........
        ........
        PPPPPPPP
        RNBQKBNR
      EOF
      position.strip.tr(' ', '')
    end
  end
end