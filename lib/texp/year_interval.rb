module TExp
  class YearInterval < IntervalRangeBase
    register_parse_callback('z')

    def initialize(base_date, interval, ignore_day_in_recurrence = false)
      super('year', base_date, interval, ignore_day_in_recurrence)
    end

    protected

    def interval_includes?(date)
      ((date.year - @base_date.year) % @interval) == 0 &&
        (@ignore_day_in_recurrence || (date.month == @base_date.month && date.day == @base_date.day))
    end
  end
end
