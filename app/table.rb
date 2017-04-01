class Table
  attr_reader :robot_position
  X_LENGTH = 5.freeze
  Y_LENGTH = 5.freeze

  def place!(x, y)
    if place?(x, y)
      @robot_position = { x: x, y: y }
      true
    else
      false
    end
  end

  def place?(x, y)
    (0...X_LENGTH).include?(x) && (0...Y_LENGTH).include?(y) && !placed_at?(x, y)
  end

  def placed?
    !@robot_position.nil?
  end

  private

  def placed_at?(x, y)
    placed? && @robot_position[:x] == x && @robot_position[:y] == y
  end
end