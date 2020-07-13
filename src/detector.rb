require_relative "./detection.rb"

class Detector
  def initialize(intruder_bitmap)
    @intruder_bitmap = intruder_bitmap
    @detections = []
  end

  def push(line, line_number)
    line.split("")
        .each_cons(intruder_width)
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

  def intruder_width
    @intruder_bitmap.first.length
  end

  def check_for_new_detection(sample, column_number)
    return unless Detection.matches_head?(@intruder_bitmap, sample)

    @detections << Detection.new(@intruder_bitmap, column_number)
  end

  def push_sample_to_detections(sample, column_number)
    @detections.each do |detection|
      detection.push(sample, column_number)
    end

    @detections.reject!(&:invalid?)
  end
end
