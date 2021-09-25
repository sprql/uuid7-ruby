# frozen_string_literal: true

RSpec.describe UUID7::Generator do
  context "generate UUID v7 layout" do
    let(:timestamp) { Time.now.to_i }
    let(:sequence) { 0 }

    subject { described_class.generate(timestamp, sequence) }

    it do
      expect(subject).to contain_exactly(be_a(Integer),
                                         be_a(Integer),
                                         be_a(Integer),
                                         be_a(Integer),
                                         be_a(Integer),
                                         be_a(Integer))
    end
  end

  context "generate different layouts" do
    let(:timestamp) { Time.now.to_i }
    let(:sequence) { 0 }

    def new_uuid7
      described_class.generate(timestamp, sequence)
    end

    it do
      expect(new_uuid7).not_to eq(new_uuid7)
    end
  end
end
