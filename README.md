# CVRP_optimization

The Vehicle Routing Problem is a generalization of the classic TSP, where we have at disposal a fleet of multiple couriers to deliver the items to the customers. Here we deal with a more complicated version of the problem, where each vehicle has a limited capacity and each item has associated a number representing how much "capacity" it requires.

In this project we tried to solve this optimization problem with three different approaches: CP (using MiniZinc), SAT (using Z3), and MIP (using Gurobi). The code relative to each one of these approaches can be found in the relative folders, under the folder "src". The "out" folders list the solutions of the instances of the problem we managed to solve with the different approaches.    
In the MCP_Instances folder can be found 11 instances of the problem that we tried to solve. They are text files with the following format:     
m                        #number of couriers       
n                        #number of items/customers        
l1 l2 ... lm             #vehicle capacities       
s1 s2 ... sn             #items sizes      
dx1 dx2 ... dxn ox       #x-coordinate of delivery points  (o is the depot)      
dy1 dy2 ... dyn oy       #y-coordinate of delivery points  (o is the depot)      


In the ProjectReport.pdf file we describe in more details the work done with experimental results and considerations.

This project was done in collaboration with @LucaZucchini97 (https://github.com/LucaZucchini97)

