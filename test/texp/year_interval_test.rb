#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class YearIntervalTest < Test::Unit::TestCase

  def test_year_interval
    te = TExp::YearInterval.new(d("Feb 10, 2008"), 3)
    assert te.includes?(d("Feb 10, 2008"))
    assert ! te.includes?(d("Feb 11, 2008"))
    assert ! te.includes?(d("Feb 10, 2009"))
    assert ! te.includes?(d("Feb 10, 2010"))
    assert te.includes?(d("Feb 10, 2011"))
  end

  def test_year_interval_leap_year
    te = TExp::YearInterval.new(d("Feb 29, 2008"), 1)
    assert te.includes?(d("Feb 29, 2008"))
    assert ! te.includes?(d("Feb 28, 2008"))
    assert ! te.includes?(d("Mar 1, 2008"))
    assert ! te.includes?(d("Feb 28, 2009"))
    assert ! te.includes?(d("Mar 1, 2009"))
    assert te.includes?(d("Feb 29, 2012"))
  end

  def test_year_interval_ignore_day_in_recurrence
    te = TExp::YearInterval.new(d("Jan 31, 2008"), 2, true)
    assert te.includes?(d("Jan 31, 2008"))
    assert te.includes?(d("Feb 29, 2008"))
    assert te.includes?(d("Mar 31, 2008"))
    assert ! te.includes?(d("Jan 31, 2009"))
    assert ! te.includes?(d("Apr 30, 2009"))
    assert te.includes?(d("Jan 31, 2010"))
    assert te.includes?(d("Feb 28, 2010"))
    assert_equal "2008-01-31,2,1z", te.to_s
  end

  def test_year_interval_without_start_date
    te = TExp::YearInterval.new(0, 3)
    assert ! te.includes?(d("Feb 10, 2008"))
    assert_equal "0,3,0z", te.to_s
    assert_equal "0,3,0z", TExp.parse("0,3,0z").to_s
  end
  
  def test_year_interval_excludes_dates_before_start
    te = TExp::YearInterval.new(d("Feb 10, 2008"), 3)
    assert_not_includes te, d("Feb 10, 2007"), d("Feb 10, 2005")
  end
end

