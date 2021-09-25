# frozen_string_literal: true

require "bundler/inline"

gemfile do
  source "https://rubygems.org"

  gem "benchmark-ips"
  gem "kalibera"

  gem "uuid7"
  gem "ulid"
  gem "ksuid"
end

require "benchmark/ips"

Benchmark.ips do |x|
  x.time = 10
  x.stats = :bootstrap

  x.report("UUIDv7") { UUID7.generate }
  x.report("UUIDv4") { SecureRandom.uuid }
  x.report("ULID") { ULID.generate }
  x.report("KSUID") { KSUID.new }

  x.compare!
end
