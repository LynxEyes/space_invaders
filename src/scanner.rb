require_relative "./detector.rb"

class Scanner
  def initialize(input, intruders)
    @input = input
    @detectors = intruders.map { |it| Detector.new(it) }
  end

  def scan
    @input.each_with_index do |line, line_number|
      @detectors.each do |detector|
        detector.push(line, line_number)
      end
    end

    @detectors.map(&:positive_detections).flatten
  end
end
