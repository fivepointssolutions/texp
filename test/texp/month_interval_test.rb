#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class MonthIntervalTest < Test::Unit::TestCase

  def test_month_interval
    te = TExp::MonthInterval.new(d("Feb 10, 2008"), 3)
    assert te.includes?(d("Feb 10, 2008"))
    assert ! te.includes?(d("Mar 10, 2008"))
    assert ! te.includes?(d("Apr 10, 2008"))
    assert te.includes?(d("May 10, 2008"))
    assert ! te.includes?(d("Jun 10, 2008"))
  end

  def test_month_interval_leap_year
    te = TExp::MonthInterval.new(d("Feb 29, 2008"), 1)
    assert te.includes?(d("Feb 29, 2008"))
    assert ! te.includes?(d("Feb 28, 2008"))
    assert ! te.includes?(d("Mar 1, 2008"))
    assert te.includes?(d("Mar 29, 2008"))
    assert te.includes?(d("Apr 29, 2008"))
    assert te.includes?(d("Feb 29, 2012"))
  end

  def test_month_interval_31st
    te = TExp::MonthInterval.new(d("Jan 31, 2008"), 1)
    assert ! te.includes?(d("Feb 29, 2008"))
    assert te.includes?(d("Mar 31, 2008"))
    assert ! te.includes?(d("Apr 30, 2008"))
    assert ! te.includes?(d("Mar 1, 2008"))
  end

  def test_month_interval_ignore_day_in_recurrence
    te = TExp::MonthInterval.new(d("Jan 31, 2008"), 2, true)
    assert te.includes?(d("Jan 31, 2008"))
    assert ! te.includes?(d("Feb 29, 2008"))
    assert te.includes?(d("Mar 31, 2008"))
    assert ! te.includes?(d("Apr 30, 2008"))
    assert te.includes?(d("May 1, 2008"))
    assert_equal "2008-01-31,2,1x", te.to_s
  end
  
  def test_month_interval_without_start_date
    te = TExp::MonthInterval.new(0, 3)
    assert ! te.includes?(d("Feb 10, 2008"))
    assert_equal "0,3,0x", te.to_s
    assert_equal "0,3,0x", TExp.parse("0,3,0x").to_s
  end
  
  def test_month_interval_excludes_dates_before_start
    te = TExp::MonthInterval.new(d("Feb 10, 2008"), 3)
    assert_not_includes te, d("Feb 10, 2007"), d("Feb 10, 2005")
  end
end

