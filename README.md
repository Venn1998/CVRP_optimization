# CVRP_optimization

The Vehicle Routing Problem is a generalization of the classic TSP, where we have at disposal a fleet of multiple couriers to deliver the items to the customers. Here we deal with a more complicated version of the problem, where each vehicle has a limited capacity and each item has associated a number representing how much "capacity" it requires.
In this project we tried to solve this optimization problem with three different approaches: CP (using MiniZinc), SAT (using Z3), and MIP (using Gurobi). The code relative to each one of these approaches can be found in the relative folders, under the folder "src". The "out" folders list the solutions of the instances of the problem we managed to solve with the different approaches. In the MCP_Instances folder can be found 11 instances of the problem that we tried to solve.
In the ProjectReport.pdf file we describe in more details the work done with experimental results and considerations.
