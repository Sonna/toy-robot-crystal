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

    getter x : Int32
    getter y : Int32
    getter facing : String

    def initialize(@x = 0, @y = 0, @facing = "NORTH"); end

    def report
      puts "#{x},#{y},#{facing}"
    end

    def left
      @facing = TURN[facing]["LEFT"]
    end

    def right
      @facing = TURN[facing]["RIGHT"]
    end
  end
end
