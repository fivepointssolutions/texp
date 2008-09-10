#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class TimeExtTest < Test::Unit::TestCase
  def test_time_to_date
    assert_equal Date.today, Time.now.to_date
  end
end
