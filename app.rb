require_relative 'maze'
require_relative 'maze_solver'
require_relative 'queue'
require_relative 'stack'

# DRIVER CODE
maze = Maze.new("map.4.txt")
strategy = Queue
maze_solver = MazeSolver.new(maze, strategy)
solvable = maze_solver.solve! ? "SOLVABLE!" : "UNSOLVABLE"
puts solvable
