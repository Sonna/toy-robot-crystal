require "spec"
require "../src/toy_robot"

# def local_io(in_str : String)
#   old_stdin = STDIN
#   old_stdout = STDOUT
#   STDIN = IO::Memory.new(in_str)
#   STDOUT = IO::Memory.new
#   yield
#   $stdout.string
# ensure
#   STDIN = old_stdin
#   STDOUT = old_stdout
# end
