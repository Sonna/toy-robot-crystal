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

    # X cartesian coordinate, between `0` and `4`
    getter x : Int32
    # Y cartesian coordinate, between `0` and `4`
    getter y : Int32
    # Cardinal facing direction; e.g. `["NORTH", "EAST", "SOUTH", "WEST"]`
    getter facing : String

    def initialize(@x = 0, @y = 0, @facing = "NORTH"); end

    # Returns the Robot's current position; i.e. `x` & `y` coordinates and
    # `facing` direction
    #
    # ```
    # Robot.new.report # => "0,0,NORTH"
    # ```
    def report
      puts "#{x},#{y},#{facing}"
    end

    # Rotates the Robot left to the next Compass ordinal direction
    #
    # ```
    # robot = Robot.new
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=0, @y=0, @facing=\"NORTH\">
    #
    # robot.left # => "WEST"
    # robot.left # => "SOUTH"
    # robot.left # => "EAST"
    # robot.left # => "NORTH"
    # ```
    def left
      @facing = TURN[facing]["LEFT"]
    end

    # Rotates the Robot right to the next Compass ordinal direction
    #
    # ```
    # robot = Robot.new
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=0, @y=0, @facing=\"NORTH\">
    #
    # robot.right # => "EAST"
    # robot.right # => "SOUTH"
    # robot.right # => "WEST"
    # robot.right # => "NORTH"
    # ```
    def right # (*_args : String)
      @facing = TURN[facing]["RIGHT"]
    end

    # Moves the Robot forward in the direction it is facing, meaning either `x`
    # or `y` increase or decrease, without falling off an implied 4x4 Table
    #
    # ```
    # Robot.new(2, 2, "NORTH").move
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=2, @y=3, @facing=\"NORTH\">
    #
    # Robot.new(2, 2, "EAST").move
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=3, @y=2, @facing=\"EAST\">
    #
    # Robot.new(2, 2, "SOUTH").move
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=2, @y=1, @facing=\"SOUTH\">
    #
    # Robot.new(2, 2, "WEST").move
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=1, @y=2, @facing=\"WEST\">
    # ```
    def move
      @x += MOVE[@facing][:x]
      @y += MOVE[@facing][:y]

      @x -= MOVE[@facing][:x] if x < 0 || x > 4
      @y -= MOVE[@facing][:y] if y < 0 || y > 4
    end

    # Updates the Robot's current coordinations and facing direction to those
    # given within the `coordinates` String argument
    #
    # ```
    # Robot.new.place("2,2,NORTH")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=2, @y=2, @facing=\"NORTH\">
    #
    # Robot.new.place("3,3,EAST")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=3, @y=3, @facing=\"EAST\">
    #
    # Robot.new.place("4,1,SOUTH")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=4, @y=1, @facing=\"SOUTH\">
    #
    # Robot.new.place("0,4,WEST")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=0, @y=4, @facing=\"WEST\">
    # ```
    def place(coordinates : String)
      x, y, facing = coordinates.split(',')
      @x = x.to_i
      @y = y.to_i
      @facing = facing.to_s
    end

    # Executes a method within the Robot instance, based of the name of the
    # command given, and passes any additional Strings as arguments to that
    # method
    #
    # ```
    # Robot.new.exec("PLACE", "1,2,EAST")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=1, @y=2, @facing=\"EAST\">
    #
    # Robot.new.exec("MOVE")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=1, @y=0, @facing=\"NORTH\">
    #
    # Robot.new.exec("LEFT")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=0, @y=0, @facing=\"WEST\">
    #
    # Robot.new.exec("RIGHT")
    # # => "#<ToyRobot::Robot:0x10711cb80 @x=0, @y=0, @facing=\"EAST\">
    #
    # Robot.new.exec("REPORT")  # => "0,0,NORTH"
    # Robot.new.exec("UNKNOWN") # => nil
    # ```
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
end
