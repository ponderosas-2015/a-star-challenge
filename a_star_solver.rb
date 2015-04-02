require_relative "priority_queue"
require_relative "map"

class AStarSolver
  def initialize(map, strategy)
    @map = map
    @strategy = strategy
  end

  def search(map)
    @strategy.call(map)
  end

  def run!
    search(@map)
  end
end
