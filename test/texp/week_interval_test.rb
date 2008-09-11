#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class WeekIntervalTest < Test::Unit::TestCase

  def test_week_interval
    te = TExp::WeekInterval.new(d("Feb 10, 2008"), 3)
    assert te.includes?(d("Feb 10, 2008"))
    assert te.includes?(d("Mar 2, 2008"))
    assert te.includes?(d("Mar 23, 2008"))
    assert ! te.includes?(d("Mar 24, 2008"))
  end

  def test_week_interval_ignore_day_in_recurrence
    te = TExp::WeekInterval.new(d("Jan 31, 2008"), 2, true)
    assert te.includes?(d("Jan 31, 2008"))
    assert te.includes?(d("Feb 1, 2008"))
    assert te.includes?(d("Feb 2, 2008"))
    assert ! te.includes?(d("Feb 3, 2008"))
    assert ! te.includes?(d("Feb 7, 2008"))
    assert ! te.includes?(d("Feb 9, 2008"))
    assert te.includes?(d("Feb 10, 2008"))
    assert te.includes?(d("Feb 29, 2008"))
    assert te.includes?(d("Mar 1, 2008"))
    assert ! te.includes?(d("Mar 2, 2008"))
    assert_equal "2008-01-31,2,1u", te.to_s
  end
  
  def test_week_interval_without_start_date
    te = TExp::WeekInterval.new(0, 3)
    assert ! te.includes?(d("Feb 10, 2008"))
    assert_equal "0,3,0u", te.to_s
    assert_equal "0,3,0u", TExp.parse("0,3,0u").to_s
  end
  
  def test_week_interval_excludes_dates_before_start
    te = TExp::WeekInterval.new(d("Feb 10, 2008"), 3)
    assert_not_includes te, d("Feb 10, 2007"), d("Feb 10, 2005")
  end
end

# years = Hash.new {|h,k| h[k] = Hash.new {|h2,k2| h2[k2] = []}}
# (Date.parse('Jan 1, 2007')..Date.parse('Dec 31, 2024')).each do |date|
#   years[date.year][date.cweek] << date.to_s
# end
# years.keys.sort.each do |year|
#   years[year].keys.sort.each do |week|
#     puts "#{year}:#{week} - #{years[year][week].inspect}"
#   end
# end