require "fixedwidth/version"
require 'fixedwidth/line'

module Fixedwidth
  def self.parse(options)
    options[:delimiter] ||= ","
    @options  = options
    @options[:start]  = @options[:start].split(@options[:delimiter])
    @options[:stop]   = @options[:stop].split(@options[:delimiter])
    @options[:header] = @options[:header].split(@options[:delimiter])
    @column_positions = []
    start.zip(stop).each do |a,b|
      a, b = a.to_i, b.to_i
      a = a - 1
      b = b - a
      @column_positions << [a, b]
    end

    if block_given?
      File.open(@options[:file]).each_line do |line|
        yield Line.new(line)
      end
    end
  end

  def self.start
    @options[:start]
  end

  def self.stop
    @options[:stop]
  end

  def self.header
    @options[:header]
  end

  def self.options
    @options
  end

  def self.nil_blanks?
    @options[:nil_blanks]
  end

  def self.column_positions
    @column_positions
  end
end
