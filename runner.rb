require_relative "a_star_solver"

strategy = ARGV[0]
my_solver = AStarSolver.new("map.4.txt", strategy)
puts my_solver.run!
