require_relative "table"
require_relative "robot"

class Controller
  class Error < StandardError; end
  class InvalidArgumentsError < Error; end
  class InvalidCommandError < Error; end
  attr_reader :table, :robot

  def initialize
    @table = Table.new
    @robot = Robot.new
  end

  def execute!(command)
    action, arguments = command.split(" ", 2)
    case action
    when "PLACE"
      place!(arguments)
    when "RIGHT"
      if robot.turn?
        robot.right!
      else
        raise InvalidCommandError.new("Error: #{action} is only available after robot has been placed")
      end
    when "LEFT"
      if robot.turn?
        robot.left!
      else
        raise InvalidCommandError.new("Error: #{action} is only available after robot has been placed")
      end
    else
      raise InvalidCommandError.new("Error: #{action} is not a valid action")
    end
  end

  private

  def place!(arguments)
    raise InvalidArgumentsError.new("PLACE action requires 3 arguments: X,Y,F") if arguments.nil?
    x, y, face = arguments.split(",", 3)
    x, y = [x.to_i, y.to_i]

    # TODO: show error message if not able to place
    if robot.face?(face) && table.place?(x, y)
      robot.face = face
      table.place!(x, y)
    end
  end
end