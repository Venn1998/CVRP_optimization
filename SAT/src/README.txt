SATmodel.ipynb is a notebook that contains 4 code blocks.
- The first imports the necessary libraries
- The second is used to store the instances into a dictionary and to define useful functions. Note that to store the instances we need to have the MCP_instances folder in the same directory of the notebook SATmodel.ipynb
- The third is used to define the function that builds the solver relative to the instance passed to it as input and looks for a solution
- The fourth performs iterations to find the best solution to each instance. To run it, assign the string of the name of the desired instance to the "inst" variable, e.g. inst = 'inst01'.

The last cell will output each solution found, the total distance of it, the next upper bound for the search and the time remaining. After the timeout the best solution is the last one printed. 
