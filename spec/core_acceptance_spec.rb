require "spec_helper"
require "./src/scanner.rb"
require "./src/detector.rb"

RSpec.describe "Core Acceptance criteria" do
  let(:intruder1) do
    %w[
      --o-----o--
      ---o---o---
      --ooooooo--
      -oo-ooo-oo-
      ooooooooooo
      o-ooooooo-o
      o-o-----o-o
      ---oo-oo---
    ]
  end

  let(:intruder2) do
    %w[
      ---oo---
      --oooo--
      -oooooo-
      oo-oo-oo
      oooooooo
      --o--o--
      -o-oo-o-
      o-o--o-o
    ]
  end

  let(:scanner) do
    Scanner.new("./spec/fixtures/acceptance_radar_sample",
                [Detector.new(intruder1), Detector.new(intruder2)])
  end

  it "detects intruders" do
    detections = scanner.scan

    expect(detections.length).to eq(5)
  end
end
