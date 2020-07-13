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

  it "calculates intruder length to the number of lines of the bitmap" do
    expect(intruder.length).to eq(3)
  end
end
