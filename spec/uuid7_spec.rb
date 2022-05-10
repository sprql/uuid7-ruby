# frozen_string_literal: true

RSpec.describe UUID7 do
  it "has a version number" do
    expect(UUID7::VERSION).not_to be nil
  end

  it "generate a UUID v7 string" do
    expect(described_class.generate).to match(/\w{8}-\w{4}-7\w{3}-\w{4}-\w{4}\w{8}/)
  end
end
