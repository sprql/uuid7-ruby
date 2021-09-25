# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("uuid7" => "UUID7")
loader.setup

# UUID v7 Generator
#
module UUID7
  # Generate a new UUID v7
  #
  # @api public
  #
  # @example Generate a new UUID v7 for the current timestamp
  #   UUID7.generate
  #
  # @param timestamp [Integer] the timestamp to use for UUID v7
  # @return [String] the generated UUID v7 string
  def self.generate(timestamp: Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond))
    format("%08x-%04x-%04x-%04x-%04x%08x", *Generator.generate(*Sequencer.sequence(timestamp)))
  end
end
