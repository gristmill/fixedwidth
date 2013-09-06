$:.push(File.expand_path("../lib", __FILE__))

require 'fixedwidth'
require 'test/unit'

class FixedwidthTest < Test::Unit::TestCase
  def setup
    Fixedwidth.parse(start: '1,9,17,44,46', stop: '8,16,36,45,63',  header: 'first,last,email,blank,phone')
  end

  def test_line_transformation_formats
    line = Fixedwidth::Line.new('John    Smith   john@example.com                1-888-555-6666')

    # Types
    assert_kind_of String,  line.to_s
    assert_kind_of String,  line.to_csv
    assert_kind_of Hash,    line.to_hash

    # Formats
    assert_equal 'John,Smith,john@example.com,,1-888-555-6666', line.to_csv
    assert_equal ['John', 'Smith', 'john@example.com', '', '1-888-555-6666'], line.to_a
    assert_equal Hash[first: "John", last: "Smith", email: "john@example.com", blank: "", phone: "1-888-555-6666"], line.to_hash
  end

  def test_fixedwidth_column_position_offsets
    assert_equal [[0, 8], [8, 8], [16, 20], [43, 2], [45, 18]], Fixedwidth.column_positions
  end

  def test_fixedwidth_yield_line
    Fixedwidth.parse(file: File.dirname(__FILE__)+'/contacts.txt', start:  '1,9,17,44,46', stop: '8,16,36,45,63', header: 'first,last,email,blank,phone') do |line|
      assert_kind_of Fixedwidth::Line, line
      assert_kind_of Array, line.to_a
      assert_kind_of String, line.to_s
      assert_kind_of Hash, line.to_hash
      [:first, :last, :email, :blank, :phone].each { |header| assert line.to_hash.keys.include?(header) }
    end
  end

  def test_fixedwidth_called_on_different_file
    is_first = true
    Fixedwidth.parse(file: File.dirname(__FILE__) +'/contacts_2.txt',
                     start:  '1,8,16,35',
                     stop:   '7,15,34,48',
                     header: 'first,last,email,phone') do |line|
      if is_first
        assert_equal 'May  Jo,Smith,john@example.com,1-888-555-6666', line.to_csv
        assert_equal ['May  Jo', 'Smith', 'john@example.com', '1-888-555-6666'], line.to_a
        assert_equal Hash[first: "May  Jo", last: "Smith", email: "john@example.com", phone: "1-888-555-6666"], line.to_hash
        is_first = false
      end
    end
  end
end

