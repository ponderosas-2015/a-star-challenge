class Maze
  START_CELL = "o"
  END_CELL = "*"
  AVAILABLE_CELL = "."
  WALL_CELL = "#"
  VISITED_CELL = "X"
  TELEPORT_CELL = "@"

  def initialize(text_file)
    @text_file = text_file
    @maze = read(@text_file)
  end

  def to_s
    @maze.join("\n")
  end

  def reset!
    @maze = read(@text_file)
  end

  def clear_screen
    print "\e[2J\e[f"
  end

  def mark_cell(cell) #TODO make bang
    @maze[cell.first][cell.last] = VISITED_CELL if @maze[cell.first][cell.last] == AVAILABLE_CELL
  end

  def available?(cell)
    @maze[cell.first][cell.last] == AVAILABLE_CELL || @maze[cell.first][cell.last] == END_CELL
  end

  def start
    find(START_CELL)
  end

  def end
    find(END_CELL)
  end

  def find(character)
    @maze.each.with_index do |row, row_index|
      row.each_char.with_index do |char, col_index|
        return [row_index, col_index] if char == character
      end
    end
    nil
  end

  def find_all(character)
    all = []
    @maze.each.with_index do |row, row_index|
      row.each_char.with_index do |char, col_index|
        all << [row_index, col_index] if char == character
      end
    end
    all
  end

  def within_maze_bounds?(cell)
    cell.first >= 0 && cell.last >= 0 && cell.first < @maze.length && cell.last < @maze[cell.first].length
  end

  def available?(cell)
    @maze[cell.first][cell.last] == AVAILABLE_CELL ||
        @maze[cell.first][cell.last] == END_CELL ||
        teleporter?(cell)
  end

  def wall?(cell)
    @maze[cell.first][cell.last] == WALL_CELL
  end

  def teleporter?(cell)
    @maze[cell.first][cell.last] == TELEPORT_CELL
  end

  def teleporter_cells
    find_all(TELEPORT_CELL)
  end

  def find_edges(cell)
    possible_edges(cell).select do |cell|
      within_maze_bounds?(cell)
    end
  end

  def possible_edges(cell)
    edges = []
    if teleporter?(cell)
      teleporter_cells.each do |tcell|
        row = tcell.first
        col = tcell.last
        edges += [[row, col - 1], [row, col + 1], [row + 1, col], [row - 1, col]]
      end
    else
      row = cell.first
      col = cell.last
      edges = [[row, col - 1], [row, col + 1], [row + 1, col], [row - 1, col]]
    end
    edges
  end

  def manhattan_distance(cell, other_cell)
    (cell.first - other_cell.first).abs + (cell.last - other_cell.last).abs
  end

  def distance_to_end(cell)
    if teleporter_cells.empty?
      manhattan_distance(cell, self.end)
    else
      [manhattan_distance(cell, self.end),
       distance_to_closest_teleporter(cell) + teleporter_to_end
      ].min
    end
  end

  def teleporter_to_end
    teleporter_cells.map { |tcell|
      manhattan_distance(tcell, self.end)
    }.min
  end

  def distance_to_closest_teleporter(cell)
    teleporter_cells.map { |tcell|
      manhattan_distance(tcell, cell)
    }.min
  end

  private

  def read(text_file)
    @maze = File.readlines(text_file)
    @maze.map!(&:chomp)
  end
end
