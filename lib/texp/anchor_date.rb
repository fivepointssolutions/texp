module TExp
  class AnchorDate < Base
    register_parse_callback('v')

    attr_reader :base_date

    def initialize(base_date)
      @base_date = base_date.kind_of?(Date) ? base_date : nil
    end

    # Is +date+ included in the temporal expression.
    def includes?(date)
      !@base_date.nil? && date == @base_date
    end

    # Create a new temporal expression with a new anchor date.
    def reanchor(new_anchor_date)
      self.class.new(new_anchor_date)
    end

    # Human readable version of the temporal expression.
    def inspect
      "on #{humanize_date(@base_date)}"
    end

    # Encode the temporal expression into +codes+.
    def encode(codes)
      @base_date.nil? ? (codes << 0) : encode_date(codes, @base_date)
      codes << encoding_token
    end
  end
end
