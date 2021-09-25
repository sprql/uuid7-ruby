# frozen_string_literal: true

RSpec.describe UUID7::Sequencer do
  context "generate timestamp with sequence" do
    let(:timestamp) { Time.now.to_i }

    subject { described_class.sequence(timestamp) }

    it do
      expect(subject).to eq([timestamp, 0])
    end
  end

  context "generate sequence" do
    subject(:sequencer) { described_class.new }

    it "when different timestamp" do
      ts1 = Time.now.to_i
      ts2 = ts1 + 1

      _, sec1 = sequencer.sequence(ts1)
      _, sec2 = sequencer.sequence(ts2)

      expect(sec1).to eq(sec2)
    end

    it "when the same timestamp" do
      ts = Time.now.to_i

      _, sec1 = sequencer.sequence(ts)
      _, sec2 = sequencer.sequence(ts)

      expect(sec1).not_to eq(sec2)
    end
  end
end
