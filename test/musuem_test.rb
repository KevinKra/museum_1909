require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/musuem.rb"
require_relative "../lib/exhibit.rb"

class MusuemTest < Minitest::Test

  def setup
    @musuem = Musuem.new("Denver Museum of Nature and Science")
  end

  def test_it_exists
    assert_instance_of Musuem, @musuem
  end

  def test_it_can_read_attributes
    assert_equal "Denver Museum of Nature and Science", @musuem.name
    assert_equal [], @musuem.exhibits
  end

  def test_it_can_add_exhibits
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15) 
    assert_equal [], @musuem.exhibits
    @musuem.add_exhibit(gems_and_minerals) 
    @musuem.add_exhibit(dead_sea_scrolls) 
    @musuem.add_exhibit(imax) 
    assert_equal [gems_and_minerals, dead_sea_scrolls, imax], @musuem.exhibits
  end

end