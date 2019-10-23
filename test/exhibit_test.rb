require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/exhibit.rb"

class ExhibitTest < Minitest::Test

  def setup
    @exhibit = Exhibit.new("Gems and Minerals", 0)
  end

  def test_it_exists
    assert_instance_of Exhibit, @exhibit
  end

  def test_it_can_read_attributes
    assert_equal "Gems and Minerals", @exhibit.name
    assert_equal 0, @exhibit.cost
  end

end