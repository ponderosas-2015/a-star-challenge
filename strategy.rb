class Strategy
  DISTANCE_TO_END = Proc.new { |maze, cell|
    maze.distance_to_end(cell) }
  UNARY = Proc.new { |maze, cell| 1 }
  GRAPH_COST = 1

  def initialize(heuristic)
    @heuristic = heuristic
  end

  def solve!(maze, &step)
    raise 'Strategy must implement #solve!'
  end
end

