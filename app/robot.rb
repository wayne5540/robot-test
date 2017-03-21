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

  def left!
    @face = ROTATION[face][:left]
  end

  def right!
    @face = ROTATION[face][:right]
  end
end