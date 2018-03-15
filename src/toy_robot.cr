require "./toy_robot/*"

# TODO: Write documentation for `ToyRobot`
module ToyRobot
  class Robot
    getter x : Int32
    getter y : Int32
    getter facing : String

    def initialize(@x = 0, @y = 0, @facing = "NORTH"); end
  end
end
