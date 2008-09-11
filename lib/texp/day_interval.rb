module TExp
  class DayInterval < IntervalBase
    register_parse_callback('i')

    def initialize(base_date, interval)
      super('day', base_date, interval)
    end

    protected

    def interval_includes?(date)
      ((date.mjd - base_mjd) % @interval) == 0
    end

    private

    def base_mjd
      @base_date.mjd
    end
  end
end
