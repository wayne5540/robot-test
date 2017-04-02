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
    action, arguments = command.split
    case action
    when "PLACE"
      place!(arguments)
    when "RIGHT"
      do_place_required_action { robot.right! }
    when "LEFT"
      do_place_required_action { robot.left! }
    when "MOVE"
      do_place_required_action { move! }
    when "REPORT"
      do_place_required_action { report! }
    else
      output!("Error: #{action} is not a valid action")
    end
  end

  private

  def do_place_required_action
    if robot.orientation_set? && table.placed?
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
    new_x = table.robot_position[:x] + vector[robot.face][:x]
    new_y = table.robot_position[:y] + vector[robot.face][:y]

    table.place!(new_x, new_y)
  end

  def report!
    output!("#{table.robot_position[:x]},#{table.robot_position[:y]},#{robot.face}")
  end

  def place!(arguments)
    return nil unless valid_place_arguments?(arguments)

    x, y, face = arguments.split(",")
    x, y = [x.to_i, y.to_i]

    if robot.face?(face) && table.place?(x, y)
      robot.face = face
      table.place!(x, y)
    else
      output!("Error: InvalidArgumentsError")
    end
  end

  def valid_place_arguments?(arguments)
    if arguments.nil? || arguments.split(',').count != 3
      output!("Error: PLACE action requires 3 arguments: X,Y,F")
      return false
    end
    true
  end

  def output!(message)
    outputs << message
  end
end