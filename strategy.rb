class Strategy

  def astar(maze)
    current = maze.start
    cost_so_far, came_from = {current => 0}, {current => nil}
    add_to_store(current, cost_so_far[current] + distance_to_end(current))
    until (@store.empty? || solved?(current))
      current = get_next_in_store
      find_edges(current).reject { |cell| maze.wall?(cell) }.each do |cell|
        new_cost = cost_so_far[current] + GRAPH_COST
        if !cost_so_far.has_key?(cell) || new_cost < cost_so_far[cell]
          cost_so_far[cell] = new_cost
          add_to_store(cell, new_cost + distance_to_end(cell))
          came_from[cell] = current
        end
      end
      maze.mark_cell(current)
      maze.print_maze
      puts "STEPS: #{@steps}"
    end
    solved?(current) ? construct_path(came_from, current) : print_unsolvable
  end
end
