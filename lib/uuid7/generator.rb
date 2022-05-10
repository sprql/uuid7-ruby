# frozen_string_literal: true

module UUID7
  # UUIDv7 with millisecond precision layout
  #
  # @api private
  #
  # 48 bits for unix timestamp with millisecond precision
  # 74 bits for random data
  #
  module Generator
    VERSION_7 = 0x7000
    VARIANT_RFC4122 = 0x8000

    # Instantiates a new layout
    #
    # @example Generate a new UUID v7 layout for the millisecond
    #   UUID::V7.generate(timestamp)
    #
    # @param timestamp [Integer] the timestamp to use for the layout
    # @return [Array<Integer>] the generated UUID v7 layout
    def self.generate(timestamp)
      unix_ts_ms = timestamp & 0xffffffffffff # take 48 least significant bits of timestamp
      unix_ts_ms1 = (unix_ts_ms >> 16) & 0xffffffff # take 32 most significant bits of timestamp
      unix_ts_ms2 = (unix_ts_ms & 0xffff) # take 16 least significant bits of timestamp

      rand_a, rand_b1, rand_b2, rand_b3 = SecureRandom.gen_random(10).unpack("nnnN")
      rand_a &= 0xfff # take 12 bits of 16
      rand_b1 &= 0x3fff # take 14 bits of 16

      # https://www.ietf.org/id/draft-peabody-dispatch-new-uuid-format-03.txt#section-5.2
      #  0                   1                   2                   3
      #  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |                           unix_ts_ms                          |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |          unix_ts_ms           |  ver  |       rand_a          |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |var|                        rand_b                             |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |                            rand_b                             |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

      # layout in bits [32, 16, 16, 16, 16, 32]
      [
        unix_ts_ms1,
        unix_ts_ms2,
        (VERSION_7 | rand_a),
        (VARIANT_RFC4122 | rand_b1),
        rand_b2,
        rand_b3
      ]
    end
  end
end
