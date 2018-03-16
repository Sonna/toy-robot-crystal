require "./spec_helper"

require "stdio"

describe ToyRobot::CLI do
  describe "Process#run" do
    # WARNING this test requires that it is built first, before working
    it "can run Robot CLI with STDIN" do
      # subject = "spec/fixtures/example_a.txt"
      # subject = ToyRobot::CLI

      # Process.run(command : String, args = nil, env : Env = nil, clear_env : Bool = false,
      #             shell : Bool = false,
      #             input : Stdio = Redirect::Close,
      #             output : Stdio = Redirect::Close,
      #             error : Stdio = Redirect::Close,
      #             chdir : String? = nil) : Process::Status
      input = IO::Memory.new("REPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)
      # Process.run("bash", args: {"bin/main"}, input: input, output: output)
      # Process.run("bash", args: {"-c", "echo $(read)"}, input: input, output: output)

      input.close
      output.close
      # output, _err, in = Stdio.capture do |io|
      #   STDOUT.puts ->{ subject.run([] of String) }
      #   # STDOUT.puts ""
      #   STDERR.puts ""
      #   # io.in.puts "REPORT"
      #   io.in.puts "EXIT"

      #   [io.out.gets, io.err.gets, STDIN.gets]
      # end

      # in.should eq "REPORT\nEXIT\n"
      output.to_s.should eq "0,0,NORTH\n"
    end

    it "can run Robot CLI with STDIN" do
      input = IO::Memory.new("REPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "0,0,NORTH\n"
    end

    it "can PLACE and then REPORT" do
      input = IO::Memory.new("PLACE 3,3,SOUTH\nREPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "3,3,SOUTH\n"
    end

    it "Robot CLI EXIT" do
      input = IO::Memory.new("EXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq ""
    end

    it "Robot CLI REPORT" do
      input = IO::Memory.new("REPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "0,0,NORTH\n"
    end

    it "Robot CLI MOVE" do
      input = IO::Memory.new("MOVE\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq ""
    end

    it "Robot CLI MOVE and then REPORT" do
      input = IO::Memory.new("MOVE\nREPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "0,1,NORTH\n"
    end

    it "Robot CLI LEFT" do
      input = IO::Memory.new("LEFT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq ""
    end

    it "Robot CLI LEFT and then REPORT" do
      input = IO::Memory.new("LEFT\nREPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "0,0,WEST\n"
    end

    it "Robot CLI RIGHT" do
      input = IO::Memory.new("RIGHT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq ""
    end

    it "Robot CLI RIGHT and then REPORT" do
      input = IO::Memory.new("RIGHT\nREPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "0,0,EAST\n"
    end

    it "Robot CLI PLACE" do
      input = IO::Memory.new("PLACE 3,3,SOUTH\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq ""
    end

    it "Robot CLI PLACE and then REPORT" do
      input = IO::Memory.new("PLACE 3,3,SOUTH\nREPORT\nEXIT\n")
      output = IO::Memory.new

      Process.run("bin/main", input: input, output: output)

      input.close
      output.close

      output.to_s.should eq "3,3,SOUTH\n"
    end
  end

  describe "#run" do
    it "can run Robot CLI with a file called example_a.txt" do
      subject = "spec/fixtures/example_a.txt"

      output, _err, in = Stdio.capture do |io|
        STDOUT.puts ToyRobot::CLI.run([subject] of String)
        STDERR.puts ""
        io.in.puts "REPORT\nEXIT\n"

        [io.out.gets, io.err.gets, STDIN.gets]
      end

      output.should eq "0,0,NORTH"
    end

    it "can run Robot CLI with a file called example_b.txt" do
      subject = "spec/fixtures/example_b.txt"

      output = Stdio.capture do |io|
        STDOUT.puts ToyRobot::CLI.run([subject] of String)
        io.out.gets
      end

      output.should eq "0,1,NORTH"
    end

    it "can run Robot CLI with a file called example_c.txt" do
      subject = "spec/fixtures/example_c.txt"

      output = Stdio.capture do |io|
        STDOUT.puts ToyRobot::CLI.run([subject] of String)
        io.out.gets
      end

      output.should eq "3,3,NORTH"
    end
  end
end
