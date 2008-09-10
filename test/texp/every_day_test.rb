#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class EveryDayTest < Test::Unit::TestCase

  def test_every_day
    te = TExp::EveryDay.new
    assert te.includes?(Date.parse("Feb 15, 2008"))
  end
end

