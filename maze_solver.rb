require_relative 'maze'
require_relative 'queue'
require_relative 'stack'
require_relative 'priority_queue'

class MazeSolver
  STRATEGY = "BFS"
  GRAPH_COST = 1

  def initialize(text_maze, strategy=STRATEGY)
    @maze = Maze.new(text_maze)
    @strategy = strategy.downcase
    @store = get_store_for_strategy(@strategy).new
    @steps = 0
  end

  def get_store_for_strategy(strategy)
    case strategy
    when "bfs"
      Queue
    when "dfs"
      Stack
    when "pq", "astar"
      PriorityQueue
    else
      Queue
    end
  end

  def add_to_store(cell, priority=nil)
    case @strategy
    when "dfs"
      @store.push(cell)
    when "pq"
      @store.add(cell, -distance_to_end(cell))
    when "astar"
      @store.add(cell, -priority)
    else
      @store.enqueue(cell)
    end
  end

  def get_next_in_store
    @steps += 1
    case @strategy
    when "dfs"
      @store.pop
    when "pq", "astar"
      @store.pull
    else
      @store.dequeue
    end
  end

  def solve!
    return a_star_solve! if @strategy == "astar"
    current = @maze.start
    came_from = {current => nil}
    add_to_store(current)
    until (@store.empty? || solved?(current))
      current = get_next_in_store
      if @maze.available?(current) || @maze.start == current
        find_edges(current).each do |cell|
          if @maze.available?(cell)
            add_to_store(cell)
            came_from[cell] ||= current
          end
        end
        @maze.mark_cell(current)
        @maze.print_maze
        puts "STEPS: #{@steps}"
      end
    end
    solved?(current) ? construct_path(came_from, current) : print_unsolvable
  end

  def a_star_solve!
    current = @maze.start
    cost_so_far, came_from = {current => 0}, {current => nil}
    add_to_store(current, cost_so_far[current] + distance_to_end(current))
    until (@store.empty? || solved?(current))
      current = get_next_in_store
      find_edges(current).reject { |cell| @maze.wall?(cell) }.each do |cell|
        new_cost = cost_so_far[current] + GRAPH_COST
        if !cost_so_far.has_key?(cell) || new_cost < cost_so_far[cell]
          cost_so_far[cell] = new_cost
          add_to_store(cell, new_cost + distance_to_end(cell))
          came_from[cell] = current
        end
      end
      @maze.mark_cell(current)
      @maze.print_maze
      puts "STEPS: #{@steps}"
    end
    solved?(current) ? construct_path(came_from, current) : print_unsolvable
  end

  def print_unsolvable
    @maze.reset!
    puts @maze
    puts "UNSOLVABLE"
  end

  def construct_path(came_from, cell)
    @maze.reset!
    path = Stack.new
    until cell == @maze.start
      cell = came_from[cell]
      path.push(cell)
    end
    until path.empty?
      @maze.mark_cell(path.pop)
      @maze.print_maze
    end
    puts "STEPS: #{@steps}"
  end

  def solved?(current)
    current == @maze.end
  end

  def find_edges(cell)
    possible_edges(cell).select do |cell|
      @maze.within_maze_bounds?(cell)
    end
  end

  def possible_edges(cell)
    row = cell.first
    col = cell.last
    [[row, col - 1], [row, col + 1], [row + 1, col], [row - 1, col]]
  end

  def manhattan_distance(cell, other_cell)
    (cell.first - other_cell.first).abs + (cell.last - other_cell.last).abs
  end

  def distance_to_end(cell)
    manhattan_distance(cell, @maze.end)
  end
end
