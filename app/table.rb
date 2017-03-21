class Table
  attr_accessor :robot_position
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
    (0...X_LENGTH).include?(x) && (0...Y_LENGTH).include?(y) && !placed?(x, y)
  end

  private

  def placed?(x, y)
    !@robot_position.nil? && @robot_position[:x] == x && @robot_position[:y] == y
  end
end