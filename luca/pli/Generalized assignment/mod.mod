# ci sono dei jobs e delle macchine
# le macchine devono eseguire i jobs
# i jobs hanno dei tempi di esecuzione che variano a seconda della macchina
# i jobs hanno dei costi che variano a seconda della macchiana
# le macchine hanno un tempo limite di funzionamento

# il mio obbiettivo è suddividere i jobs tra le varie macchine minimizzando il costo

param n_jobs;
param n_macchine;

set jobs := 1 .. n_jobs;
set macchine := 1 .. n_macchine;

param tempi_esecuzione {jobs, macchine};
param costi_esecuzione {jobs, macchine};

param limite_tempo_macchina {macchine};


## COSA SCELGO ?
# per ogni task e per macchina
# questa macchina verrà utizzata per il mio task
## Matrice con righe = jobs e colonne = macchine

var uso_macchina {jobs, macchine} binary;

## Cosa non posso fare?

# Assegnare più di una macchina o nessuna ad un job
# => per ogni j in jobs la somma per le m macchine dell'uso macchina deve essere = 1

s.t. assegnamento_macchina_jobs{j in jobs}:
    sum{m in macchine} uso_macchina[j, m] = 1;

# Le macchine non devono superare il limite di tempo di lavoro
# => per ogni macchina la somma per i jobs dell'uso della macchina pesata ..
# sui tempi di esecuzione deve essere minore o uguale del limite della macchina

s.t. limite_uso_macchina{m in macchine}:
    sum{j in jobs} uso_macchina[j, m] * tempi_esecuzione[j, m] <= limite_tempo_macchina[m];


######
# Cosa voglio ottenere?

## voglio minimizzare i costi dei jobs => 
# minimizzare la somma per ogni j in jobs del costo del job 
# costo del job è la somma per le macchine del uso_macchina pesato con costi_esecuzione 

minimize costo_jobs: sum{j in jobs} sum{m in macchine} uso_macchina[j,m] * costi_esecuzione[j,m];

data;

param n_jobs := 9;
param n_macchine := 3;

param limite_tempo_macchina :=
1 380
2 360
3 350
;


param tempi_esecuzione :
    1   2   3 := 
1 100   102   97
2 111   110   113
3 98    103   96
4 132   130   135
5 120   123   117
6 115   112   118
7 142   145   140
8 123   120   125
9 90    93    88
;



param costi_esecuzione :
    1   2   3       :=
1   24  42  23
2   30  45  23
3   33  54  16
4   37  45  18
5   34  47  22
6   31  42  25
7   30  41  19
8   28  47  15
9   25  50  20
;
