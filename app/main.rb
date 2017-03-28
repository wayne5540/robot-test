require_relative "controller"

controller = Controller.new

command = gets.chomp()
while command
  controller.execute!(command)

  while !controller.outputs.empty?
    puts controller.outputs.shift
  end

  command = gets.chomp()
end