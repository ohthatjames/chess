module Chess
  class Square
    def initialize(notation_or_file, rank=nil)
      if rank.nil?
        @notation = notation_or_file
      else
        @notation = (notation_or_file + ?a.ord).chr + (rank + 1).to_s
      end
    end

    def notation
      @notation
    end

    def rank
      @notation[1,1].to_i - 1
    end

    def file
      @notation[0].ord - ?a.ord
    end

    def offset(file_offset, rank_offset)
      Square.new(file + file_offset, rank + rank_offset)
    end

    def ==(other)
      file == other.file && rank == other.rank
    end
  end
end
