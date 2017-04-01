require_relative "table"
require_relative "robot"

class Controller
  attr_reader :table, :robot, :outputs

  def initialize
    @table = Table.new
    @robot = Robot.new
    @outputs = []
  end

  def execute!(command)
    action, arguments = command.split(" ", 2)
    case action
    when "PLACE"
      place!(arguments)
    when "RIGHT"
      do_advanced_action { robot.right! }
    when "LEFT"
      do_advanced_action { robot.left! }
    when "MOVE"
      do_advanced_action { move! }
    when "REPORT"
      do_advanced_action { report! }
    else
      output!("Error: #{action} is not a valid action")
    end
  end

  private

  def do_advanced_action
    if robot.turn? && table.placed?
      yield
    else
      output!("Error: robot has not been placed yet")
    end
  end

  def move!
    vector = {
      north: { x: 0, y: 1 },
      west: { x: -1, y: 0 },
      south: { x: 0, y: -1 },
      east: { x: 1, y: 0 }
    }
    new_cordination = { x: table.robot_position[:x] + vector[robot.face][:x], y: table.robot_position[:y] + vector[robot.face][:y] }
    table.place!(new_cordination[:x], new_cordination[:y])
  end

  def report!
    output!("#{table.robot_position[:x]},#{table.robot_position[:y]},#{robot.face}")
  end

  def place!(arguments)
    if arguments.nil?
      output!("Error: PLACE action requires 3 arguments: X,Y,F")
      return
    end
    x, y, face = arguments.split(",", 3)
    x, y = [x.to_i, y.to_i]

    if robot.face?(face.to_s) && table.place?(x, y)
      robot.face = face
      table.place!(x, y)
    else
      output!("Error: InvalidArgumentsError")
    end
  end

  def output!(message)
    outputs << message
  end
end