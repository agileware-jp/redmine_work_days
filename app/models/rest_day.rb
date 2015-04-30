class RestDay < ActiveRecord::Base
  unloadable
  
  default_scope order("#{RestDay.table_name}.day ASC")
  
  scope :in_year, lambda{|year| where(:day => year.beginning_of_year..year.end_of_year)}
  scope :between, lambda{|day1, day2| where(:day => day1..day2)}
  
  validates_presence_of :day
  validates_length_of :description, :maximum => 200, :allow_nil => true

  class << self
    def rest_day?(date)
      date = Date.parse(date) unless date.is_a?(Date)
      !!rest_days.detect { |d| d.day == date }
    end

    def rest_days
      @rest_days ||= all
    end

    def clear!
      @rest_days = nil
    end
  end
end
