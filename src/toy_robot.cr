require "./toy_robot/*"

# TODO: Write documentation for `ToyRobot`
module ToyRobot
  class Robot
    TURN = {
      "NORTH" => {"LEFT" => "WEST", "RIGHT" => "EAST"},
      "SOUTH" => {"LEFT" => "EAST", "RIGHT" => "WEST"},
      "EAST"  => {"LEFT" => "NORTH", "RIGHT" => "SOUTH"},
      "WEST"  => {"LEFT" => "SOUTH", "RIGHT" => "NORTH"},
    }

    MOVE = {
      "NORTH" => {x: 0, y: 1},
      "SOUTH" => {x: 0, y: -1},
      "EAST"  => {x: 1, y: 0},
      "WEST"  => {x: -1, y: 0},
    }

    getter x : Int32
    getter y : Int32
    getter facing : String

    def initialize(@x = 0, @y = 0, @facing = "NORTH"); end

    def report # (*_args : String)
      puts "#{x},#{y},#{facing}"
    end

    def left # (*_args : String)
      @facing = TURN[facing]["LEFT"]
    end

    def right # (*_args : String)
      @facing = TURN[facing]["RIGHT"]
    end

    def move # (*_args : String)
      @x += MOVE[@facing][:x]
      @y += MOVE[@facing][:y]

      @x -= MOVE[@facing][:x] if x < 0 || x > 4
      @y -= MOVE[@facing][:y] if y < 0 || y > 4
    end

    def place(coordinates : String)
      x, y, facing = coordinates.split(',')
      @x = x.to_i
      @y = y.to_i
      @facing = facing.to_s
    end

    def exec(raw_command : String = "", raw_command_args : String = "")
      case raw_command
      when "PLACE"  then place(raw_command_args)
      when "MOVE"   then move
      when "LEFT"   then left
      when "RIGHT"  then right
      when "REPORT" then report
      else
        # do nothing
      end
    end
  end

  module CLI
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
