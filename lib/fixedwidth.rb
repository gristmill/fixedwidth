require "fixedwidth/version"

module Fixedwidth
  def self.parse(options)
    @options = options
    @options[:delimiter] ||= ","

    if block_given?
      File.open(@options[:file]).each_line do |line|
        yield Line.new(line)
      end
    end
  end

  def self.start
    @start ||= @options[:start].split(@options[:delimiter])
  end

  def self.stop
    @stop ||= @options[:stop].split(@options[:delimiter])
  end

  def self.header
    @header ||= @options[:header].split(@options[:delimiter])
  end

  def self.options
    @options
  end

  def self.column_positions
    [].tap do |positions|
      start.zip(stop).each do |a,b|
        a, b = a.to_i, b.to_i
        a = a - 1
        b = b-a

        positions << [a,b]
      end
    end
  end

  class Line
    def initialize(line)
      @line = line
    end

    def to_s
      @line
    end

    def to_hash
      Fixedwidth.header.zip(to_a).inject({}){ |sum, d| sum.merge(Hash[d[0].to_sym, d[1]]) }
    end

    def to_a
      to_csv.split(Fixedwidth.options[:delimiter])
    end

    def to_csv
      [].tap do |results|
        Fixedwidth.column_positions.each do |a,b|
          results << @line[a,b]
        end
      end.join(Fixedwidth.options[:delimiter]).gsub(/\s{2}/, '').split(Fixedwidth.options[:delimiter]).map(&:strip).join(Fixedwidth.options[:delimiter]) # TODO: Actually think about this!
    end
  end

end
