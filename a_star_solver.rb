require_relative "priority_queue"

class AStarSolver
  START = "o"
  WALL = "#"
  OPEN = "."
  VISITED = "x"
  TARGET = "*"
  CLEAR_SCREEN = "\e[2J\e[f"

  attr_reader :map, :width, :height
  def initialize(filename, strategy)
    @map = File.read(filename)
    @original_map = File.read(filename)
    @width = @map.index("\n") + 1
    @start = @map.index(START)
    @target = @map.index(TARGET)
    @strategy = strategy
  end

  def on_map?(index)
    index >= 0 && index <= (@map.length - 1)
  end

  def open_space?(index)
    @map[index] == OPEN || @map[index] == TARGET || @map[index] == START
  end

  def valid?(index)
    return on_map?(index) && open_space?(index)
  end

  def neighbors(index)
    right_index = index + 1
    bottom_index = index + @width
    left_index = index - 1
    top_index = index - @width
    [bottom_index, right_index, top_index, left_index]
  end

  def valid_neighbors(index)
    neighbors(index).select { |neighbor| valid?(neighbor) }
  end

  def print_map(current_index, steps)
    print CLEAR_SCREEN
    puts @map
    puts "Steps: #{steps}"
    sleep(0.05)
  end

  def row_column(index)
    row = index/@width
    column = index % @width
    [row, column]
  end

  def manhattan_distance(index)
    index_row, index_column = row_column(index)
    target_row, target_column = row_column(@target)
    (index_row - target_row).abs + (index_column - target_column).abs
  end

  def bfs?
    @strategy == "bfs"
  end

  def a_star
    steps = 0
    came_from = {}
    cost_so_far = {}
    priority_queue = PriorityQueue.new
    priority_queue.add(@start, 0)
    cost_so_far[@start] = 0
    while !priority_queue.empty?
      current_index = priority_queue.pull
      return came_from if @map[current_index] == TARGET
      new_cost = cost_so_far[current_index] + 1 #could take the slowness factor from the graph here but we're just doing a uniform map
      steps += 1
      @map[current_index] = VISITED
      print_map(current_index, steps)
      valid_neighbors(current_index).each do |neighbor|
        if !cost_so_far.has_key?(neighbor) || new_cost < cost_so_far[neighbor]
          cost_so_far[neighbor] = new_cost
          priority = new_cost + manhattan_distance(neighbor)
          priority_queue.add(neighbor, priority)
          came_from[neighbor] = current_index
        end
      end
    end
    false
  end

  def search
    steps = 0
    came_from = {}
    if bfs?
      stack_queue = PriorityQueue.new
      stack_queue.add(@start, manhattan_distance(@start))
    else
      stack_queue = []
      stack_queue.push(@start)
    end
    while !stack_queue.empty?
      if bfs?
        current_index = stack_queue.pull
      else
        current_index = stack_queue.pop
      end
      if valid?(current_index)
        return came_from if @map[current_index] == TARGET
        @map[current_index] = VISITED
        steps += 1
        print_map(current_index, steps)
        neighbors(current_index).each do |neighbor|
          if !came_from[neighbor]
            if bfs?
              stack_queue.add(neighbor, manhattan_distance(neighbor))
            else
              stack_queue.push(neighbor)
            end
            came_from[neighbor] = current_index
          end
        end
      end
    end
    false
  end

  def build_path(came_from_hash)
    current = came_from_hash[@target]
    path = [current]
    while current != @start
      current = came_from_hash[current]
      path.push(current)
    end
    path
  end

  def final_path(came_from_hash)
    return "unsolvable" if !came_from_hash
    path = build_path(came_from_hash)
    path.each do |index|
      @original_map[index] = "x"
    end
    return [@original_map, path.length]
  end

  def run!
    map, length = final_path(a_star)
    puts map
    puts "Path Length: #{length}"
  end

end
