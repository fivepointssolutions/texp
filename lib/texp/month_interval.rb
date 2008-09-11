module TExp
  class MonthInterval < IntervalRangeBase
    register_parse_callback('x')

    def initialize(base_date, interval, ignore_day_in_recurrence = false)
      super('year', base_date, interval, ignore_day_in_recurrence)
    end

    protected

    def interval_includes?(date)
      ((date.month - @base_date.month) % @interval) == 0 && (@ignore_day_in_recurrence || date.day == @base_date.day)
    end
  end
end
