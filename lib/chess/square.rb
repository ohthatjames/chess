module Chess
  class Square
    def initialize(notation)
      @notation = notation
    end

    def rank
      @notation[1,1].to_i - 1
    end

    def file
      @notation[0].ord - ?a.ord
    end
  end
end
