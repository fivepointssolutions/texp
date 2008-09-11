module TExp
  class WeekInterval < IntervalRangeBase
    register_parse_callback('u')

    def initialize(base_date, interval, ignore_day_in_recurrence = false)
      super('week', base_date, interval, ignore_day_in_recurrence)
    end

    protected

    def interval_includes?(date) # :nodoc:
      anchor_start_of_week = start_of_week(@base_date)
      date_start_of_week = start_of_week(date)
      weeks_apart = (date_start_of_week - anchor_start_of_week) / 7
      (weeks_apart % @interval) == 0 && (@ignore_day_in_recurrence || date.wday == @base_date.wday)
    end

    private

    def start_of_week(date)
      date - date.wday
    end
  end
end
