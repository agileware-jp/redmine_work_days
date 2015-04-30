require_dependency 'redmine/utils'

# Patch for Redmine::Utils::DateCalculation
module RedmineUtilsDateCalculationPatch

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :working_days,           :rest_day
      alias_method_chain :add_working_days,       :rest_day
      alias_method_chain :next_working_date,      :rest_day
      alias_method_chain :non_working_week_days,  :rest_day
      alias :non_working_week_day?  :non_working_week_day?  # FIXME check why this solves NoMethodError
      alias :non_working_day?       :non_working_day?       # FIXME check why this solves NoMethodError
    end
  end

  module InstanceMethods
    # Returns the number of working days between from and to
    def working_days_with_rest_day(from, to)
      (from...to).inject(0) do |days, date|
        if non_working_day?(date)
          days
        else
          days + 1
        end
      end
    end

    # Adds working days to the given date
    def add_working_days_with_rest_day(from, working_days)
      if working_days > 0
        result = from + working_days
        while working_days > working_days(from, result)
          result = next_working_date(result + 1)
        end
        next_working_date(result)
      else
        from
      end
    end

    # Returns the date of the first day on or after the given date that is a working day
    def next_working_date_with_rest_day(date)
      next_working_date = date
      while non_working_day?(next_working_date)
        next_working_date += 1
      end
      next_working_date
    end

    # Returns the index of non working week days (1=monday, 7=sunday)
    def non_working_week_days_with_rest_day
      @non_working_week_days ||= begin
        days = Setting.non_working_week_days
        if days.is_a?(Array) && days.size < 7
          days.map(&:to_i)
        else
          []
        end
      end
    end

    # Checks if a date is non working week day
    def non_working_week_day?(date)
      non_working_week_days.include?(((date.cwday - 1) % 7) + 1)
    end

    # Checks if a date is non working day
    def non_working_day?(date)
      non_working_week_day?(date) || RestDay.rest_day?(date)
    end
  end
end
