require "fixedwidth/version"
require 'fixedwidth/line'

module Fixedwidth
  def self.parse(options)
    @semaphore ||= Mutex.new  # This wouldn't be necessary if this was turned
    @semaphore.synchronize do # into a class instead of a module
      setup(options)
      if block_given?
        File.open(@options[:file]).each_line do |line|
          yield Line.new(line)
        end
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

  private
  def self.setup(options)
    @options = options
    @options[:delimiter] ||= ","
    if @options[:start].is_a? String
      @options[:start]  = @options[:start].split(@options[:delimiter])
    end
    if @options[:stop].is_a? String
      @options[:stop]   = @options[:stop].split(@options[:delimiter])
    end
    if @options[:header].is_a? String
      @options[:header] = @options[:header].split(@options[:delimiter])
    end
    @column_positions = []
    start.zip(stop).each do |a,b|
      a, b = a.to_i, b.to_i
      a = a - 1
      b = b - a
      @column_positions << [a, b]
    end
  end
end
