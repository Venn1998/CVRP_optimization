MIPmodel is a notebook that contains 3 codeblocks:
- The first is used to store the informations about all the available instances.
- The second is used to run the desired instance.
- The third is used to print the output of the model in a clear way.

To run and get the output, for example, for the instance "inst01" on the MIP model:
- Run the first block of the notebook
- Assign to the variable "inst_to_run" the value "inst01" on the second block of the notebook 
- Set the desired maximum computational time at line 60 of the second block (default 300 seconds)
- Run the second block 
- After the end of the run of the second block, just run the third block to obtain the output.
- If the model didn't find any feasible solution, the output of the third block will be:
	
	Total distance: N/A
	Tour planned:
	---------------------------
	N/A