class Table
  attr_reader :robot_position

  def initialize(width: 5, length: 5)
    @width = width
    @length = length
  end

  def place!(x, y)
    if place?(x, y)
      @robot_position = { x: x, y: y }
      true
    else
      false
    end
  end

  def place?(x, y)
    (0...@width).include?(x) && (0...@length).include?(y) && !placed_at?(x, y)
  end

  def placed?
    !@robot_position.nil?
  end

  private

  def placed_at?(x, y)
    placed? && @robot_position[:x] == x && @robot_position[:y] == y
  end
end