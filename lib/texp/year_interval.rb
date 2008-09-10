module TExp
  class YearInterval < Base
    register_parse_callback('z')

    attr_reader :base_date, :interval

    # If ignore_day_in_recurrence is true, the expression will match any
    # Date that has a year attribute at the specified intervals from base_date.
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
        ((date.year - @base_date.year) % @interval) == 0 &&
          (@ignore_day_in_recurrence || (date.month == @base_date.month && date.day == @base_date.day))
      end
    end

    # Create a new temporal expression with a new anchor date.
    def reanchor(new_anchor_date)
      self.class.new(new_anchor_date, @interval, @ignore_day_in_recurrence)
    end

    # Human readable version of the temporal expression.
    def inspect
      if @interval == 1
        "every year starting on #{humanize_date(@base_date)}"
      else
        "every #{ordinal(@interval)} year starting on #{humanize_date(@base_date)}"
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

    class << self
      def parse_callback(stack)
        ignore_day_in_recurrence = stack.pop
        interval = stack.pop
        date = stack.pop
        stack.push TExp::YearInterval.new(date, interval, (ignore_day_in_recurrence == 1))
      end
    end
  end
end
