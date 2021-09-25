# frozen_string_literal: true

module UUID7
  # UUIDv7 with millisecond precision layout
  #
  # @api private
  #
  # 32 bits for unix timestamp seconds
  # 12 bits for millisecond precision
  # 62 bits for random data
  #
  module Generator
    VERSION_7 = 0x7000
    VARIANT_RFC4122 = 0x8000

    # Instantiates a new layout
    #
    # @example Generate a new UUID v7 layout for the millisecond and sequence count
    #   UUID::V7.generate(timestamp, sequence)
    #
    # @param timestamp [Integer] the timestamp to use for the layout
    # @param seq [Integer] the sequence to use for the layout
    # @return [Array<Integer>] the generated UUID v7 layout
    def self.generate(timestamp, seq)
      unixts = timestamp / 1_000 # seconds of unix timestamp
      unixts1 = (unixts >> 4) & 0xffffffff # take 32 most significant bits of 36
      unixts2 = (unixts & 0xf) << 12 # take 4 least significant bits of 36

      msec = timestamp % 1_000 # milliseconds of unix timestamp
      msec &= 0xfff # take 12 bits of 16

      rand1, rand2, rand3 = SecureRandom.gen_random(8).unpack("nnN")
      rand1 &= 0x3fff # take 14 bits of 16

      # https://datatracker.ietf.org/doc/html/draft-peabody-dispatch-new-uuid-format-01#section-4.4.4.1
      #
      #  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |                            unixts1                            |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |unixts2|         msec          |  ver  |          seq          |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |var|           rand1           |             rand2             |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      # |                             rand3                             |
      # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      [
        unixts1,
        (unixts2 | msec),
        (VERSION_7 | seq),
        (VARIANT_RFC4122 | rand1),
        rand2,
        rand3
      ]
    end
  end
end
