require_relative "./detection"

class Detector
  def initialize(intruder)
    @intruder = intruder
    @detections = []
  end

  def push(line, line_number)
    line.split("")
        .each_cons(@intruder.width)
        .map(&:join)
        .each_with_index do |sample, column_number|
          check_for_new_detection(sample, column_number)
          push_sample_to_detections(sample, column_number)
        end
  end

  def positive_detections
    @detections.select(&:positive?)
  end

  private

  def check_for_new_detection(sample, column_number)
    return unless Detection.matches_head?(@intruder, sample)

    @detections << Detection.new(@intruder, column_number)
  end

  def push_sample_to_detections(sample, column_number)
    @detections.each do |detection|
      detection.push(sample, column_number)
    end

    @detections.reject!(&:invalid?)
  end
end
