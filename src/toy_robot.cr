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

    def report
      puts "#{x},#{y},#{facing}"
    end

    def left
      @facing = TURN[facing]["LEFT"]
    end

    def right
      @facing = TURN[facing]["RIGHT"]
    end

    def move
      @x += MOVE[@facing][:x]
      @y += MOVE[@facing][:y]

      @x -= MOVE[@facing][:x] if x < 0 || x > 4
      @y -= MOVE[@facing][:y] if y < 0 || y > 4
    end

    def place(coordinates : String)
      x, y, facing = coordinates.split(",")
      @x = x.to_i
      @y = y.to_i
      @facing = facing.to_s
    end
  end
end
