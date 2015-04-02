How do the the strategies stack up in terms of steps taken and length of path? What trade-offs did you witness?
  the bfs with the heuristic not always find the shortest path but usually does. At times it takes longer to find it whereas the dfs does not guarentee finding the shortest path but when there is the possibility that it will find the end in fewer steps.

How does the heuristic search differ visually from the others? Why?
  yes it tends to clump towards the target.  This is because the heuristic (in my case the manhattan equation) prioritizes those neighbors with the shortest distance to the target.

  Sometimes it gets attracted to a corner because of the manhattan distance even though it is a dead end

Is the heuristic path better, worse, or the same as your other approaches?
  yes it's better for almost all maps although there are certain maps where the depth-first finds the end faster though it isn't necessarily the optimal path

Can you construct a map where your heuristic search does better than your other strategies? Can you construct a map where it does worse?
