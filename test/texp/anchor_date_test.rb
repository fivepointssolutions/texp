#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__)) + '/../texp_tests'

class AnchorDateTest < Test::Unit::TestCase

  def test_reanchor
    date = d('Feb 14, 2008')
    te = TExp::AnchorDate.new(date)
    assert te.includes?(date)
    assert ! te.includes?(date + 1)
    
    te = te.reanchor(date + 1)
    assert ! te.includes?(date)
    assert te.includes?(date + 1)
  end
  
end

