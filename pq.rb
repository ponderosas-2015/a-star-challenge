require_relative 'strategy'
require_relative 'priority_queue'

class PQ < Strategy

  def initialize(heuristic=DISTANCE_TO_END)
    @heuristic = heuristic
  end

  def solve!(maze)
    frontier = PriorityQueue.new
    current = maze.start
    came_from = {current => nil}
    frontier.add(current, -@heuristic.call(maze, current))
    until (frontier.empty? || current == maze.end)
      current = frontier.pull
      if maze.available?(current) || maze.start == current
        maze.find_edges(current).select {|cell| maze.available?(cell) }
          .each do |cell|
            frontier.add(cell, -@heuristic.call(maze, cell))
            came_from[cell] ||= current
          end
      end
      maze.mark_cell(current)
      yield current
    end
    current == maze.end ? came_from : {}
  end

end
