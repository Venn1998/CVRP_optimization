include "circuit.mzn";
include "arg_sort.mzn";



% =================================================%
% PARAMETERS DECLARATION
% =================================================%

int: N ;                                
int : M ;
array[1..M] of int : Capacities ;  
array[1..N] of int: Weights ;           
array[1..N+1, 1..N+1] of int :Distance ;                               

set of int: COURIERS = 1..M ;             
set of int: DELIVERY_POINTS = 1..N ;      
set of int: LOAD = 0..max(Capacities) ;   

set of int: POINTS = 1..N+2*M ;                 
set of int: DEPOT_POINTS = N+1..N+2*M ;         
set of int: START_DEPOT_POINTS = N+1..N+M ;      
set of int: END_DEPOT_POINTS = N+M+1..N+2*M ;    


% VARIABLES DECLARATION
%------------------------------


array[POINTS] of var POINTS: next ;         
array[POINTS] of var POINTS: previous ;     
array[POINTS] of var COURIERS: courier ;    
array[POINTS] of var LOAD: load ;           

var int: total_distance ;                   


% CONSTRAINTS DECLARATION
%-------------------------------


% ------------- initialization constraints ------------- %
% points that precede start points are arrival points

constraint redundant_constraint(
   forall(n in (N+2..N+M)) (
     previous[n] = n + M-1
   )
);

constraint redundant_constraint(
   previous[N+1] = N+2*M
);

% points that follow arrival points are start points

constraint 
   forall(n in (N+M+1..N+2*M-1)) (
     next[n] = n-M+1 
   );
constraint
   next[N+2*M] = N+1;

% association of each start/arrival point with a courier

constraint 
   forall(n in START_DEPOT_POINTS) (
     courier[n] = n-N
   );
   
constraint 
   forall(n in END_DEPOT_POINTS) (
     courier[n] = n-N-M
   );

% load of courier when starting at the depot

constraint 
   forall(n in START_DEPOT_POINTS) (
     load[n] = 0 
   );


% ------------- predecessor/successor constraints ------------- %

constraint redundant_constraint(
   forall(n in POINTS) (
      next[previous[n]] = n
   )
);

constraint redundant_constraint(
   forall(n in POINTS) (
      previous[next[n]] = n
   )
);

constraint(
    forall(n in DELIVERY_POINTS where load[n] < Capacities[courier[n]] ) (
    next[n] in array2set(arg_sort([Distance[n,j] | j in DELIVERY_POINTS where j!=n])) \/ next[n] > N
    )
);

% alldiff + subtour elimination constraints

constraint 
   circuit(next);
constraint redundant_constraint(
   circuit(previous)
);

% ------------- courier constraints ------------- %
% the courier of point 'i' is the same as the courier of the previous point

constraint redundant_constraint(
   forall(n in DELIVERY_POINTS) (
      courier[previous[n]] = courier[n]
   )
);
constraint 
   forall(n in DELIVERY_POINTS) (
      courier[next[n]] = courier[n]
   );


% ------------- load constraints ------------- %

constraint 
   forall(n in DELIVERY_POINTS) (
      load[n] = load[previous[n]] + Weights[n]
   );
   
constraint
   forall(n in END_DEPOT_POINTS) (
      load[n] = load[previous[n]] 
   );
   
constraint
   forall(n in POINTS) (
      load[n] <= Capacities[courier[n]]         
   );

%Symmetry breaking constraints
%-----------------------------------

% S/B[1]
%constraint symmetry_breaking_constraint(forall(n in DELIVERY_POINTS where previous[n] > N) (
%       next[n] > n)
%      );

%S/B[2]
%constraint symmetry_breaking_constraint(forall(n in DELIVERY_POINTS where previous[n] > N, j in DELIVERY_POINTS where next[j] >N /\ courier[n] = courier[j])(
%       (next[n] > j))
%      );


% Objective function
%-----------------------------


constraint
 total_distance = sum (i in DELIVERY_POINTS where previous[i] <= N) ( Distance[previous[i],i]) +
                  sum (i in DELIVERY_POINTS where previous[i] > N ) ( Distance[N+1,i]) +
                  sum (i in DELIVERY_POINTS where next[i] > N)   ( Distance[i,N+1]) ;
             

annotation relax_and_reconstruct(array[int] of var int,int) ;


solve :: seq_search([int_search([next[j] | j in POINTS], dom_w_deg, indomain_random, complete),  
                     int_search(courier, first_fail, indomain_split, complete),                         
                    ])   
                    :: relax_and_reconstruct(next, 97)
                    :: restart_constant(300)
                    %:: restart_geometric(1.5,150)
                    %:: restart_luby(100)
                    %:: restart_linear(300)
minimize total_distance ; 


output 
   [ "objective = "] ++ [show(total_distance)] ++
   [ ";\ncourier = " ] ++ [ show(courier) ] ++
   [ ";\nnext = "] ++          [ show(next) ] ++
   [ ";\n"]
;