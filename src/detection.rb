require "damerau-levenshtein"

class Detection
  MAX_LINE_DEVIATION = 2
  MAX_ALLOWED_DEVIATION = 3

  def self.matches_head?(intruder, sample)
    DamerauLevenshtein.distance(intruder[0], sample) <= MAX_LINE_DEVIATION
  end

  def initialize(intruder, column_number)
    @intruder = intruder
    @column_number = column_number
    @current_line = 0
    @current_deviation = 0

    @invalid = false
    @positive = false
  end

  def push(sample, column_number)
    return if positive? || invalid?
    return if column_number != @column_number

    @current_deviation += current_line_matches(sample)
    @current_line += 1

    if @current_deviation > MAX_ALLOWED_DEVIATION
      @invalid = true
    end

    @positive = matched_all_intruder?
  end

  def positive?
    @positive
  end

  def invalid?
    @invalid
  end

  private

  def current_line_matches(sample)
    DamerauLevenshtein.distance(@intruder.bitmap[@current_line], sample)
  end

  def matched_all_intruder?
    @current_line == @intruder.length
  end
end
