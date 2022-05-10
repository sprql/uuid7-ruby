# frozen_string_literal: true

require "uuid7"

module UUID7SpecHelpers
  def make_timestamp
    Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond)
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include UUID7SpecHelpers
end
