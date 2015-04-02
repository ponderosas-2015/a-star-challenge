require_relative 'maze_solver'

maze = ARGV.first || "map.1.txt"
strategy = ARGV[1]

# DRIVER CODE
maze_solver = MazeSolver.new(maze, strategy)
maze_solver.solve!
