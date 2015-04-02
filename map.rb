require_relative "strategies"

class Map
  include Strategies

  attr_reader :start, :target, :map_string
  def initialize(string)
    @original_map_string = string.clone
    @map_string = string
    @width = @map_string.index("\n") + 1
    @start = @map_string.index(START)
    @target = @map_string.index(TARGET)
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

  def to_s
    @map_string
  end

  def final_path(came_from_hash)
    return false if came_from_hash == false
    path = build_path(came_from_hash)
    path.each do |index|
      @original_map_string[index] = "x"
    end
    return [@original_map_string, path.length]
  end

  def manhattan_distance(index)
    index_row, index_column = row_column(index)
    target_row, target_column = row_column(@target)
    (index_row - target_row).abs + (index_column - target_column).abs
  end

  private

  def on_map?(index)
    index >= 0 && index <= (@map_string.length - 1)
  end

  def open_space?(index)
    @map_string[index] == OPEN || @map_string[index] == TARGET || @map_string[index] == START
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

  def row_column(index)
    row = index/@width
    column = index % @width
    [row, column]
  end
end
