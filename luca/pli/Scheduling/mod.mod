# Jobs
# 
# abbiamo un set di Jobs
# i jobs hanno un tempo di esecuzione
# i jobs hanno una finestra temporale
#     - inizio
#     - fine
# 
# scelgo, per ogni jobs, quando far iniziare quel job
# 
# i job non devono sovrapporsi
# :: per ogni j, g : j != g, start[g] not in [start[j], start[j]+tempo[j]] 
#   
#
# i job devono iniziare nella loro finestra temporale
# :: per ogni j, start[j] >= inizio[j]
# 
# i job devono finire nella loro finestra temporale
# :: per ogni j, start[j] + tempo <= fine[j]

set jobs:= 1..7;

param tempo{jobs};
param inizio{jobs};
param fine{jobs};

var scheduling_start {j in jobs} >= inizio[j], <= fine[j]-tempo[j];
var predecessori    {jobs, jobs} binary;


s.t. set_predecessori {j1 in jobs , j2 in jobs : j1 <> j2}:
    predecessori[j1,j2] + predecessori[j2,j1] = 1;

s.t. sovvrapposizioni {j1 in jobs, j2 in jobs : j1 <> j2}:
    scheduling_start[j1] >= (scheduling_start[j2] + tempo[j2]) -1000 * predecessori[j2,j1];

var massima_fine >= 0;
s.t. maximize_fine {j1 in jobs}:
    massima_fine >= scheduling_start[j1] + tempo[j1];

minimize tempo_complessivo: massima_fine;


data;

param tempo :=
1 10 
2 14
3 21
4 18 
5 4
6 23
7 35
;

param inizio :=
1  15
2  0
3  0
4  10
5   5
6  13 
7  18;

param fine :=
1  50
2  80
3  95
4  75
5  30
6  130
7  120;

end;
