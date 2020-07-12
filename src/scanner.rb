class Scanner
  def initialize(filename, detectors)
    @file = File.open(filename, "r")
    @detectors = detectors
  end

  def scan
    @file.each_with_index do |line, line_number|
      @detectors.each do |detector|
        detector.push(line, line_number)
      end
    end

    @detectors.map(&:detections).join
  end
end
