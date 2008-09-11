module TExp
  class WeekInterval < Base
    register_parse_callback('u')

    attr_reader :base_date, :interval

    # If ignore_day_in_recurrence is true, the expression will match any
    # Date that has a week attribute at the specified intervals from base_date.
    #
    def initialize(base_date, interval, ignore_day_in_recurrence = false)
      @base_date = base_date.kind_of?(Date) ? base_date : nil
      @interval = interval
      @ignore_day_in_recurrence = ignore_day_in_recurrence
    end

    # Is +date+ included in the temporal expression.
    def includes?(date)
      if @base_date.nil? || date < @base_date
        false
      else
        anchor_start_of_week = start_of_week(@base_date)
        date_start_of_week = start_of_week(date)
        weeks_apart = (date_start_of_week - anchor_start_of_week) / 7
        (weeks_apart % @interval) == 0 && (@ignore_day_in_recurrence || date.wday == @base_date.wday)
      end
    end

    # Create a new temporal expression with a new anchor date.
    def reanchor(new_anchor_date)
      self.class.new(new_anchor_date, @interval, @ignore_day_in_recurrence)
    end

    # Human readable version of the temporal expression.
    def inspect
      if @interval == 1
        "every week starting on #{humanize_date(@base_date)}"
      else
        "every #{ordinal(@interval)} week starting on #{humanize_date(@base_date)}"
      end
    end

    # Encode the temporal expression into +codes+.
    def encode(codes)
      if @base_date
        encode_date(codes, @base_date)
      else
        codes << 0
      end
      codes << ',' << @interval << ',' << (@ignore_day_in_recurrence ? 1 : 0) << encoding_token
    end

    private

    def start_of_week(date)
      date - date.wday
    end

    class << self
      def parse_callback(stack)
        ignore_day_in_recurrence = stack.pop
        interval = stack.pop
        date = stack.pop
        stack.push TExp::WeekInterval.new(date, interval, (ignore_day_in_recurrence == 1))
      end
    end
  end
end
