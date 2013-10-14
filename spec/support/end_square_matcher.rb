class HaveEndSquaresMatcher < RSpec::Matchers::BuiltIn::MatchArray
  def initialize(from, board, expected_end_squares)
    @from, @board = from, board
    super(expected_end_squares)
  end

  def match(expected, actual)
    @actual = actual.end_squares(Chess::Square.new(@from), @board).map(&:notation)
    super(@expected, @actual)
  end
end

def have_end_squares(from, board, expected_end_squares)
  HaveEndSquaresMatcher.new(from, board, expected_end_squares)
end
