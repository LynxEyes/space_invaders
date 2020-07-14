require "damerau-levenshtein"

class Detection
  # -----------------------------------------------------------------
  # NOTE: This could be isolated into an strategy pattern like thing!!
  MAX_LINE_DEVIATION = 2
  MAX_ALLOWED_DEVIATION = 3

  def self.deviation(line, sample)
    DamerauLevenshtein.distance(line, sample)
  end

  def self.matches_head?(intruder_bitmap, sample)
    deviation(intruder_bitmap.first, sample) <= MAX_LINE_DEVIATION
  end
  # -----------------------------------------------------------------

  def initialize(intruder_bitmap, column_number, line_number)
    @intruder_bitmap = intruder_bitmap.dup
    @column_number = column_number
    @line_number = line_number
    @width = intruder_bitmap.first.length
    @height = intruder_bitmap.length

    @current_deviation = 0

    @invalid = false
    @positive = false
  end

  def push(sample, column_number)
    return if positive? || invalid?
    return if column_number != @column_number

    line = next_bitmap_line!
    @current_deviation += self.class.deviation(line, sample)
    # -----------------------------------------------------------------
    @invalid = @current_deviation > MAX_ALLOWED_DEVIATION # This could also be part of the strategy
    # -----------------------------------------------------------------
    @positive = !invalid? && finished?
  end

  def positive?
    @positive
  end

  def invalid?
    @invalid
  end

  def position
    {
      x: @column_number,
      y: @line_number,
      width: @width,
      height: @height
    }
  end

  private

  def next_bitmap_line!
    @intruder_bitmap.shift
  end

  def finished?
    @intruder_bitmap.empty?
  end
end
