require_relative "a_star_solver"
require_relative "strategies"

class Runner
  include Strategies

  def initialize(map_number, user_strategy)
    @map = Map.new(File.read("map.#{map_number}.txt"))
    @solver = AStarSolver.new(@map, strategy(user_strategy.downcase))
  end

  def strategy(user_strategy)
    case user_strategy
    when "bfs"
      BFS
    when "dfs"
      DFS
    when "heuristic"
      HEURISTIC
    when "a_star"
      A_STAR
    end
  end

  def run!
    result = @solver.run!
    if result == false
      puts "unsolvable"
    else
      shortest_route, length = result
      puts shortest_route
      puts "Path Length: #{length}"
    end
  end

end

Runner.new(ARGV[0], ARGV[1]).run!







