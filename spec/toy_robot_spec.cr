require "./spec_helper"

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
end
