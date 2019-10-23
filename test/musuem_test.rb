require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/musuem.rb"
require_relative "../lib/exhibit.rb"
require_relative "../lib/patron.rb"

class MusuemTest < Minitest::Test

  def setup
    @musuem = Musuem.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15) 
  end

  def test_it_exists
    assert_instance_of Musuem, @musuem
  end

  def test_it_can_read_attributes
    assert_equal "Denver Museum of Nature and Science", @musuem.name
    assert_equal [], @musuem.exhibits
  end

  def test_it_can_add_exhibits
    assert_equal [], @musuem.exhibits
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @musuem.exhibits
  end

  def test_it_can_recommend_exhibits
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls") 
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")  
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    assert_equal [@dead_sea_scrolls, @gems_and_minerals], @musuem.recommend_exhibits(bob)
    assert_equal [@imax], @musuem.recommend_exhibits(sally)
  end

end