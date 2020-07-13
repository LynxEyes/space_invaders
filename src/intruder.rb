Intruder = Struct.new(:bitmap) do
  def length
    bitmap.length
  end

  def width
    bitmap.first.length
  end

  def head_matches?(sample)
    sample == bitmap.first
  end
end
