# frozen_string_literal: true

require_relative "lib/uuid7/version"

Gem::Specification.new do |spec|
  spec.name          = "uuid7"
  spec.version       = UUID7::VERSION
  spec.authors       = ["Alexander Obukhov"]
  spec.email         = ["dev@sprql.space"]

  spec.summary       = "UUID v7 generator"
  spec.description   = "Implementation of UUID v7"
  spec.homepage      = "https://github.com/sprql/uuid7-ruby"
  spec.licenses      = ['MIT']
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir.glob("{lib}/**/*") + %w(LICENSE README.md)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "zeitwerk", "~> 2.4"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
