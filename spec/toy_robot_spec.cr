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
end
