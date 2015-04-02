require_relative 'strategy'
require_relative 'priority_queue'

class AStar < Strategy
  DISTANCE_TO_END = Proc.new do |maze, cell|
    maze.distance_to_end(cell)
  end

  def initialize(heuristic=DISTANCE_TO_END)
    @heuristic = heuristic
  end

  def solve!(maze)
    frontier = PriorityQueue.new
    current = maze.start
    cost_so_far, came_from = {current => 0}, {current => nil}
    frontier.add(current, -(cost_so_far[current] + @heuristic.call(maze, current)))
    until (frontier.empty? || current == maze.end)
      current = frontier.pull
      maze.find_edges(current).reject { |cell| maze.wall?(cell) }.each do |cell|
        new_cost = cost_so_far[current] + GRAPH_COST
        if !cost_so_far.has_key?(cell) || new_cost < cost_so_far[cell]
          cost_so_far[cell] = new_cost
          frontier.add(cell, -(new_cost + @heuristic.call(maze, current)))
          came_from[cell] = current
        end
      end
      maze.mark_cell(current)
      yield current
    end
    current == maze.end ? came_from : {}
  end

end
