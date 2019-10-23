require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/exhibit.rb"

class ExhibitTest < Minitest::Test

  def setup
    @exhibit = Exhibit.new
  end

  def test_it_exists
    assert_instance_of Exhibit, @exhibit
  end

end