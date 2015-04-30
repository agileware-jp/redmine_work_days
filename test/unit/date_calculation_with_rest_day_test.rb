require File.expand_path('../../test_helper', __FILE__)

class RedmineUtilsDateCalculationWithRestDayTest < ActiveSupport::TestCase
  include Redmine::Utils::DateCalculation

  def test_working_days_without_non_working_week_days
    with_settings :non_working_week_days => [] do
      RestDay.create!(:day => Date.parse("2012-10-10"), :description => "Health Sports Day")
      RestDay.create!(:day => Date.parse("2012-10-16"), :description => "Dummy 1")
      RestDay.create!(:day => Date.parse("2012-10-30"), :description => "Dummy 2")
      RestDay.clear!

      # 2012-10-09 Tue
      assert_equal 18-2, working_days('2012-10-09'.to_date, '2012-10-27'.to_date)
      assert_equal  6-1, working_days('2012-10-09'.to_date, '2012-10-15'.to_date)
      assert_equal  5-1, working_days('2012-10-09'.to_date, '2012-10-14'.to_date)
      assert_equal  3-1, working_days('2012-10-09'.to_date, '2012-10-12'.to_date)
      assert_equal  3-1, working_days('2012-10-14'.to_date, '2012-10-17'.to_date)
      assert_equal 16-1, working_days('2012-10-14'.to_date, '2012-10-30'.to_date)
    end
  end

  def test_working_days_with_non_working_week_days
    with_settings :non_working_week_days => %w(6 7) do
      RestDay.create!(:day => Date.parse("2012-10-10"), :description => "Health Sports Day")
      RestDay.create!(:day => Date.parse("2012-10-16"), :description => "Dummy 1")
      RestDay.create!(:day => Date.parse("2012-10-30"), :description => "Dummy 2")
      RestDay.clear!

      # 2012-10-09 Tue
      assert_equal 14-2, working_days('2012-10-09'.to_date, '2012-10-27'.to_date)
      assert_equal  4-1, working_days('2012-10-09'.to_date, '2012-10-15'.to_date)
      assert_equal  4-1, working_days('2012-10-09'.to_date, '2012-10-14'.to_date)
      assert_equal  3-1, working_days('2012-10-09'.to_date, '2012-10-12'.to_date)
      assert_equal  8-2, working_days('2012-10-09'.to_date, '2012-10-19'.to_date)
      assert_equal  8-1, working_days('2012-10-11'.to_date, '2012-10-23'.to_date)
      assert_equal  2-1, working_days('2012-10-14'.to_date, '2012-10-17'.to_date)
      assert_equal 11-1, working_days('2012-10-14'.to_date, '2012-10-30'.to_date)
    end
  end
end
