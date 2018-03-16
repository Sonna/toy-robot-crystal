require "./spec_helper"

require "stdio"

describe ToyRobot do
  it "has a Version" do
    ToyRobot::VERSION.should be_truthy
  end

  describe "#new" do
    it "can build a Robot instance" do
      subject = ToyRobot::Robot.new

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "NORTH"
    end

    it "can build a Robot instance with x=1" do
      subject = ToyRobot::Robot.new(1)

      subject.x.should eq 1
      subject.y.should eq 0
      subject.facing.should eq "NORTH"
    end

    it "can build a Robot instance with x=1 y=2" do
      subject = ToyRobot::Robot.new(1, 2)

      subject.x.should eq 1
      subject.y.should eq 2
      subject.facing.should eq "NORTH"
    end

    it "can build a Robot instance with x=1 y=2 facing=SOUTH" do
      subject = ToyRobot::Robot.new(1, 2, "SOUTH")

      subject.x.should eq 1
      subject.y.should eq 2
      subject.facing.should eq "SOUTH"
    end
  end

  describe "#report" do
    it "can report its current position" do
      subject = ToyRobot::Robot.new

      # output, err, in = Stdio.capture do |io|
      output = Stdio.capture do |io|
        STDOUT.puts subject.report # ":)"
        # STDERR.puts ":("
        # io.in.puts ":P"

        # [io.out.gets, io.err.gets, STDIN.gets]
        io.out.gets
      end

      output.should eq "0,0,NORTH"
    end

    it "can report its current position when at 2,3,WEST" do
      subject = ToyRobot::Robot.new(2, 3, "WEST")
      output = Stdio.capture do |io|
        STDOUT.puts subject.report

        io.out.gets
      end

      output.should eq "2,3,WEST"
    end
  end

  describe "#left" do
    it "can turn from facing=NORTH to facing=WEST" do
      subject = ToyRobot::Robot.new
      subject.left

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "WEST"
    end

    it "can turn from facing=WEST to facing=SOUTH" do
      subject = ToyRobot::Robot.new(0, 0, "WEST")
      subject.left

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "SOUTH"
    end

    it "can turn from facing=SOUTH to facing=EAST" do
      subject = ToyRobot::Robot.new(0, 0, "SOUTH")
      subject.left

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "EAST"
    end

    it "can turn from facing=EAST to facing=NORTH" do
      subject = ToyRobot::Robot.new(0, 0, "EAST")
      subject.left

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "NORTH"
    end
  end

  describe "#right" do
    it "can turn from facing=NORTH to facing=EAST" do
      subject = ToyRobot::Robot.new
      subject.right

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "EAST"
    end

    it "can turn from facing=EAST to facing=SOUTH" do
      subject = ToyRobot::Robot.new(0, 0, "EAST")
      subject.right

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "SOUTH"
    end

    it "can turn from facing=SOUTH to facing=WEST" do
      subject = ToyRobot::Robot.new(0, 0, "SOUTH")
      subject.right

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "WEST"
    end

    it "can turn from facing=WEST to facing=NORTH" do
      subject = ToyRobot::Robot.new(0, 0, "WEST")
      subject.right

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "NORTH"
    end
  end

  describe "#move" do
    it "can move from default position" do
      subject = ToyRobot::Robot.new
      subject.move

      subject.x.should eq 0
      subject.y.should eq 1
      subject.facing.should eq "NORTH"
    end

    it "can move SOUTH" do
      subject = ToyRobot::Robot.new(2, 2, "SOUTH")
      subject.move

      subject.x.should eq 2
      subject.y.should eq 1
      subject.facing.should eq "SOUTH"
    end

    it "can move WEST" do
      subject = ToyRobot::Robot.new(3, 3, "WEST")
      subject.move

      subject.x.should eq 2
      subject.y.should eq 3
      subject.facing.should eq "WEST"
    end

    it "can move from 0,0,EAST" do
      subject = ToyRobot::Robot.new(0, 0, "EAST")
      subject.move

      subject.x.should eq 1
      subject.y.should eq 0
      subject.facing.should eq "EAST"
    end

    it "does not move off the table from 0,0,SOUTH" do
      subject = ToyRobot::Robot.new(0, 0, "SOUTH")
      subject.move

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "SOUTH"
    end

    it "does not move off the table from 0,0,WEST" do
      subject = ToyRobot::Robot.new(0, 0, "WEST")
      subject.move

      subject.x.should eq 0
      subject.y.should eq 0
      subject.facing.should eq "WEST"
    end

    it "does not move off the table from 0,4,WEST" do
      subject = ToyRobot::Robot.new(0, 4, "WEST")
      subject.move

      subject.x.should eq 0
      subject.y.should eq 4
      subject.facing.should eq "WEST"
    end

    it "does not move off the table from 0,4,NORTH" do
      subject = ToyRobot::Robot.new(0, 4, "NORTH")
      subject.move

      subject.x.should eq 0
      subject.y.should eq 4
      subject.facing.should eq "NORTH"
    end

    it "does not move off the table from 4,4,NORTH" do
      subject = ToyRobot::Robot.new(4, 4, "NORTH")
      subject.move

      subject.x.should eq 4
      subject.y.should eq 4
      subject.facing.should eq "NORTH"
    end

    it "does not move off the table from 4,4,EAST" do
      subject = ToyRobot::Robot.new(4, 4, "EAST")
      subject.move

      subject.x.should eq 4
      subject.y.should eq 4
      subject.facing.should eq "EAST"
    end

    it "does not move off the table from 4,0,EAST" do
      subject = ToyRobot::Robot.new(4, 0, "EAST")
      subject.move

      subject.x.should eq 4
      subject.y.should eq 0
      subject.facing.should eq "EAST"
    end

    it "does not move off the table from 4,0,SOUTH" do
      subject = ToyRobot::Robot.new(4, 0, "SOUTH")
      subject.move

      subject.x.should eq 4
      subject.y.should eq 0
      subject.facing.should eq "SOUTH"
    end
  end

  describe "#place" do
    it "can place the Robot at 4,2,WEST" do
      subject = ToyRobot::Robot.new
      subject.place("4,2,WEST")

      subject.x.should eq 4
      subject.y.should eq 2
      subject.facing.should eq "WEST"
    end

    it "can place the Robot at 2,3,SOUTH" do
      subject = ToyRobot::Robot.new
      subject.place("2,3,SOUTH")

      subject.x.should eq 2
      subject.y.should eq 3
      subject.facing.should eq "SOUTH"
    end
  end
end
