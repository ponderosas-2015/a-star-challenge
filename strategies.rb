require_relative "priority_queue"

module Strategies
  START = "o"
  WALL = "#"
  OPEN = "."
  VISITED = "x"
  TARGET = "*"
  CLEAR_SCREEN = "\e[2J\e[f"

  PRINT_MAP = Proc.new do |map, steps|
    print CLEAR_SCREEN
    puts map
    puts "Steps: #{steps}"
    sleep(0.05)
  end

  MANHATTAN_DISTANCE = Proc.new do |map, index|
    map.manhattan_distance(index)
  end

  A_STAR = Proc.new do |map, *args|
    print_map = PRINT_MAP
    steps = 0
    came_from = {}
    cost_so_far = {}
    frontier = PriorityQueue.new
    frontier.add(map.start, 0)
    cost_so_far[map.start] = 0
    result = false
    while !frontier.empty?
      current_index = frontier.pull
      result = map.final_path(came_from) if map.map_string[current_index] == TARGET
      break if !result == false
      new_cost = cost_so_far[current_index] + 1 #could take the slowness factor from the graph here but we're just doing a uniform map
      steps += 1
      map.map_string[current_index] = VISITED
      print_map.call(map, steps)
      map.valid_neighbors(current_index).each do |neighbor|
        if !cost_so_far.has_key?(neighbor) || new_cost < cost_so_far[neighbor]
          cost_so_far[neighbor] = new_cost
          priority = new_cost + MANHATTAN_DISTANCE.call(map, neighbor)
          frontier.add(neighbor, priority)
          came_from[neighbor] = current_index
        end
      end
    end
    result
  end

  BFS = Proc.new do |map, *args|
    print_map = PRINT_MAP
    steps = 0
    came_from = {}
    frontier = []
    frontier.push(map.start)
    result = false
    while !frontier.empty?
      current_index = frontier.shift
      if map.valid?(current_index)
        result = map.final_path(came_from) if map.map_string[current_index] == TARGET
        break if !result == false
        steps += 1
        map.map_string[current_index] = VISITED
        print_map.call(map, steps)
        map.neighbors(current_index).each do |neighbor|
          if map.valid?(neighbor)
            frontier.push(neighbor)
            came_from[neighbor] = current_index
          end
        end
      end
    end
    result
  end

  DFS = Proc.new do |map, *args|
    print_map = PRINT_MAP
    steps = 0
    came_from = {}
    frontier = []
    frontier.push(map.start)
    result = false
    while !frontier.empty?
      current_index = frontier.pop
      if map.valid?(current_index)
        result = map.final_path(came_from) if map.map_string[current_index] == TARGET
        break if !result == false
        steps += 1
        map.map_string[current_index] = VISITED
        print_map.call(map, steps)
        map.neighbors(current_index).each do |neighbor|
          frontier.push(neighbor)
          came_from[neighbor] = current_index
        end
      end
    end
    result
  end

  HEURISTIC = Proc.new do |map, *args|
    heuristic = MANHATTAN_DISTANCE
    print_map = PRINT_MAP
    steps = 0
    came_from = {}
    frontier = PriorityQueue.new
    frontier.add(map.start, heuristic.call(map, map.start))
    result = false
    while !frontier.empty?
      current_index = frontier.pull
      if map.valid?(current_index)
        result = map.final_path(came_from) if map.map_string[current_index] == TARGET
        break if !result == false
        map.map_string[current_index] = VISITED
        steps += 1
        print_map.call(map, steps)
        map.neighbors(current_index).each do |neighbor|
          if !came_from[neighbor]
            frontier.add(neighbor, heuristic.call(map, neighbor))
            came_from[neighbor] = current_index
          end
        end
      end
    end
    result
  end
end
