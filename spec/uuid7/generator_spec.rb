# frozen_string_literal: true

RSpec.describe UUID7::Generator do
  context "generate UUID v7 layout" do
    let(:timestamp) { make_timestamp }

    subject { described_class.generate(timestamp) }

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
    let(:timestamp) { make_timestamp }

    def new_uuid7
      described_class.generate(timestamp)
    end

    it do
      expect(new_uuid7).not_to eq(new_uuid7)
    end
  end
end
