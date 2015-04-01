require_relative 'maze'
require_relative 'maze_solver'
require_relative 'queue'
require_relative 'stack'

def get_strategy(s)
  case s
  when "bfs" || "BFS"
    Queue
  when "dfs" || "DFS"
    Stack
  else
    Queue
  end
end

maze = ARGV.first || "map.1.txt"
strategy = get_strategy(ARGV[1])
# DRIVER CODE
maze_solver = MazeSolver.new(maze, strategy)
maze_solver.solve!
