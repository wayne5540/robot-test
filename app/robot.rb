class Robot
  attr_reader :face

  def face=(orientation)
    @face = downcase_symbol(orientation) if face?(orientation)
  end

  def face?(orientation)
    !rotation[downcase_symbol(orientation)].nil?
  end

  def orientation_set?
    !face.nil?
  end

  def left!
    @face = rotation[face][:left] if orientation_set?
  end

  def right!
    @face = rotation[face][:right] if orientation_set?
  end

  private

  def rotation
    @rotation ||= {
      north: {
        left: :west, right: :east
      },
      west: {
        left: :south, right: :north
      },
      south: {
        left: :east, right: :west
      },
      east: {
        left: :north, right: :south
      }
    }
  end

  def downcase_symbol(string)
    string.downcase.to_sym
  end
end