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
    left_index = index - 1
    top_index = index - @width
    right_index = index + 1
    bottom_index = index + @width
    [left_index, top_index, right_index, bottom_index]
  end

  def print_map(current_index, steps)
    print CLEAR_SCREEN
    puts @map
    puts "Steps: #{steps}"
    sleep(0.01)
  end

  def search
    steps = 0
    queue_stack = []
    queue_stack.push(@start)
    came_from = {}
    while !queue_stack.empty?
      if @strategy == "bfs"
        current_index = queue_stack.shift
      else
        current_index = queue_stack.pop
      end
      if valid?(current_index)
        return came_from if @map[current_index] == TARGET
        @map[current_index] = VISITED
        print_map(current_index, steps)
        steps += 1
        neighbors(current_index).each do |neighbor|
          if !came_from[neighbor]
            queue_stack.push(neighbor)
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
    return @original_map
  end

  def run!
    puts final_path(search)
  end

end
