Intruder = Struct.new(:bitmap) do
  def width
    bitmap.first.length
  end

  def head_matches?(sample)
    sample == bitmap.first
  end
end
