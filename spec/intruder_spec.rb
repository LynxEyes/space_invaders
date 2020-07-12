require "spec_helper.rb"
require "./src/intruder.rb"

RSpec.describe Intruder do
  let(:bitmap) do
    %w[
      --o--
      -ooo-
      ooooo
    ]
  end

  subject(:intruder) { described_class.new(bitmap) }

  it "calculates intruder width to the width of the bitmap lines" do
    expect(intruder.width).to eq(5)
  end

  it "signals a potential match when a sample equals the first bitmap line" do
    expect(intruder.head_matches?("--o--")).to be_truthy
  end

  it "doesn't signal a potential match when a sample differs the first bitmap line" do
    expect(intruder.head_matches?("o-o-o")).to be_falsy
  end
end
