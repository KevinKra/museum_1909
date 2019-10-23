require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/patron.rb"

class PatronTest < Minitest::Test

  def setup
    @patron = Patron.new
  end

  def test_it_exists
    assert_instance_of Patron, @patron
  end

end