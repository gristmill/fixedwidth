require 'csv'
module Fixedwidth
  class Line
    def initialize(line)
      @line = line
    end

    def to_s
      @line
    end

    def to_hash
      Fixedwidth.header.zip(to_a).inject({}){ |i,(a,b)| i.merge(a.to_sym => b) }
    end

    def to_a
      array = Fixedwidth.column_positions.map do |start, stop|
        field = @line[start, stop]
        field.strip!
        if Fixedwidth.nil_blanks? && field.length == 0
         field = nil
        end
        field
      end
    end

    def to_csv
      CSV.generate_line(to_a, col_sep: Fixedwidth.options[:delimiter]).chomp
    end
  end
end
