class Table
  X_LENGTH = 5.freeze
  Y_LENGTH = 5.freeze

  def place?(x, y)
    (0...X_LENGTH).include?(x) && (0...Y_LENGTH).include?(y)
  end
end