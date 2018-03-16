module ToyRobot
  # The Command Line Interface entrypoint to the application
  module CLI
    # The CLI method entrypoint to be called within `main.cr` with CLI arguments
    #
    # ```
    # ToyRobot::CLI.run(ARGV)
    # ```
    def self.run(args : Array(String))
      robot = Robot.new

      filename = args.first? && args.first
      input = filename ? File.new(filename) : STDIN

      input.each_line do |line|
        raw_commands = line.split(' ', 3)
        command_method = raw_commands.first
        args = raw_commands.size > 1 ? raw_commands[1] : ""

        robot.exec(command_method, args) if command_method
        break if command_method == "EXIT"
      end
    end
  end
end
