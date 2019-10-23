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
    @bob = Patron.new("Bob", 20)
    @bob.add_interest("Dead Sea Scrolls") 
    @bob.add_interest("Gems and Minerals")
    @sally = Patron.new("Sally", 20)
    @sally.add_interest("IMAX")
    @tj = Patron.new("TJ", 7) 
    @tj.add_interest("IMAX")
    @tj.add_interest("Dead Sea Scrolls")
    @tj.add_interest("Gems and Minerals")
  end

  def test_it_exists
    assert_instance_of Musuem, @musuem
  end

  def test_it_can_read_attributes
    assert_equal "Denver Museum of Nature and Science", @musuem.name
    assert_equal [], @musuem.exhibits
    assert_equal [], @musuem.patrons
  end

  def test_it_can_add_exhibits
    assert_equal [], @musuem.exhibits
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @musuem.exhibits
  end

  def test_it_can_recommend_exhibits
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    assert_equal [@dead_sea_scrolls, @gems_and_minerals], @musuem.recommend_exhibits(@bob)
    assert_equal [@imax], @musuem.recommend_exhibits(@sally)
  end

  def test_it_can_admit_patrons
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    @musuem.admit(@bob)
    @musuem.admit(@sally)
    assert_equal [@bob, @sally], @musuem.patrons
  end

  def test_it_can_sort_admitted_patrons_by_interest
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    @musuem.admit(@bob)
    @musuem.admit(@sally)
    mock_assertion = { @gems_and_minerals => [@bob], @dead_sea_scrolls => [@bob], @imax => [@sally]}
    assert_equal mock_assertion, @musuem.patrons_by_exhibit_interest
  end

  def test_patrons_can_only_attend_exhibits_they_can_afford
    @musuem.add_exhibit(@gems_and_minerals) 
    @musuem.add_exhibit(@dead_sea_scrolls) 
    @musuem.add_exhibit(@imax) 
    @musuem.admit(@bob)
    @musuem.admit(@sally)
    @musuem.admit(@tj)
    mock_assertion = { @gems_and_minerals => [@bob, @tj], @dead_sea_scrolls => [@bob], @imax => [@sally]}
    assert_equal mock_assertion, @musuem.patrons_of_exhibits
    assert_equal 7, @tj.spending_money
    assert_equal 10, @bob.spending_money
    assert_equal 5, @sally.spending_money
  end
end