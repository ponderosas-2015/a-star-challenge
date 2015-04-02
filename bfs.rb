require_relative 'strategy'
require_relative 'queue'

class BFS < Strategy

  def initialize(heuristic=UNARY)
    @heuristic = heuristic
  end

  def solve!(maze)
    frontier = Queue.new
    current = maze.start
    came_from = {current => nil}
    frontier.enqueue(current)
    until (frontier.empty? || current == maze.end)
      current = frontier.dequeue
      if maze.available?(current) || maze.start == current
        maze.find_edges(current).select {|cell| maze.available?(cell) }
          .each do |cell|
            frontier.enqueue(cell)
            came_from[cell] ||= current
          end
      end
      maze.mark_cell(current)
      yield current
    end
    current == maze.end ? came_from : {}
  end

end
