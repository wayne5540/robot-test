class Robot
  attr_accessor :face

  ROTATION = {
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
  }.freeze

  def face=(orientation)
    @face = downcase_symbol(orientation) if face?(orientation)
  end

  def face?(orientation)
    !ROTATION[downcase_symbol(orientation)].nil?
  end

  def orientation_set?
    !face.nil?
  end

  def left!
    @face = ROTATION[face][:left] if orientation_set?
  end

  def right!
    @face = ROTATION[face][:right] if orientation_set?
  end

  private

  def downcase_symbol(string)
    string.downcase.to_sym
  end
end