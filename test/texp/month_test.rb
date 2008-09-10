#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class MonthTest < Test::Unit::TestCase

  def setup
    @date = Date.parse("Feb 14, 2008")
  end

  def test_initial_conditions
    te = TExp::Month.new(2)
    assert te.includes?(@date)
    assert te.includes?(@date + 1)
    assert ! te.includes?(@date + 30)
  end
end

