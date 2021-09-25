# frozen_string_literal: true

module UUID7
  # Monotonic clock sequence counter
  class Sequencer
    def self.sequence(time)
      @sequencer ||= new
      @sequencer.sequence(time)
    end

    def initialize
      @sequence = 0
      @last_timestamp = 0
      @mutex = Mutex.new
    end

    def sequence(timestamp)
      @mutex.synchronize do
        @sequence = if timestamp <= @last_timestamp
                      # TODO: handle overflow
                      ((@sequence + 1) & 0xfff) # 12 bits
                    else
                      0
                    end
        @last_timestamp = timestamp
      end

      [timestamp, @sequence]
    end
  end
end
