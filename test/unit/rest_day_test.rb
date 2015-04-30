require File.expand_path('../../test_helper', __FILE__)

class RestDayTest < ActiveSupport::TestCase

  def test_rest_day?
    assert_equal false, RestDay.rest_day?(Date.parse("2013-01-21"))
    assert_equal false, RestDay.rest_day?(Date.parse("2013-01-22"))
    assert_equal false, RestDay.rest_day?(Date.parse("2013-01-23"))
    assert_equal false, RestDay.rest_day?(Date.parse("2013-01-24"))
    assert_equal false, RestDay.rest_day?(Date.parse("2013-01-25"))

    RestDay.create!(:day => Date.parse("2013-01-21"), :description => "Mon")
    RestDay.create!(:day => Date.parse("2013-01-22"), :description => "Tue")
    RestDay.create!(:day => Date.parse("2013-01-23"), :description => "Wed")
    RestDay.create!(:day => Date.parse("2013-01-24"), :description => "Thu")
    RestDay.create!(:day => Date.parse("2013-01-25"), :description => "Fri")
    RestDay.clear!

    assert_equal true,  RestDay.rest_day?(Date.parse("2013-01-21"))
    assert_equal true,  RestDay.rest_day?(Date.parse("2013-01-22"))
    assert_equal true,  RestDay.rest_day?(Date.parse("2013-01-23"))
    assert_equal true,  RestDay.rest_day?(Date.parse("2013-01-24"))
    assert_equal true,  RestDay.rest_day?(Date.parse("2013-01-25"))
  end
end
