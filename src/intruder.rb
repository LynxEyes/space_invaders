Intruder = Struct.new(:bitmap) do
  def length
    bitmap.length
  end

  def width
    bitmap.first.length
  end

  def [](number)
    bitmap[number]
  end
end
