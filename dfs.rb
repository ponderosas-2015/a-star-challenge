require_relative 'strategy'
require_relative 'stack'

class DFS < Strategy

  def initialize(heuristic=UNARY)
    @heuristic = heuristic
  end

  def solve!(maze)
    frontier = Stack.new
    current = maze.start
    came_from = {current => nil}
    frontier.push(current)
    until (frontier.empty? || current == maze.end)
      current = frontier.pop
      if maze.available?(current) || maze.start == current
        maze.find_edges(current).select {|cell| maze.available?(cell) }
          .each do |cell|
            frontier.push(cell)
            came_from[cell] ||= current
          end
      end
      maze.mark_cell(current)
      yield current
    end
    current == maze.end ? came_from : {}
  end

end
