# Scheduling

# DATI
param nJ;
set J := 1..nJ;
param p {J};        # processing time
param r {J};        # release date
param D {J};        # deadline

# VARIABILI
var x {j1 in J,j2 in J: j1<>j2} binary; # precedenze: riga precede colonna (x=1)
var t {j in J} >=r[j], <=D[j]-p[j];     # Inizio processing di ogni job
var makespan;

# VINCOLI
subject to Coppie {i in J, j in J: i<>j}:
  x[i,j] + x[j,i] = 1;

param M := 1000;
subject to Disgiuntivi {i in J, j in J: i<>j}:
  t[j] >= (t[i]+p[i]) - M * x[j,i];

# OBIETTIVO
# Obiettivo1: minimizzare makespan
minimize z1: makespan;
subject to Def_makespan {j in J}:
  makespan >= t[j] + p[j];
# Obiettivo2: minimizzare tempo medio di completamento
#minimize z2: (1/nJ) * sum {j in J} (t[j] + p[j]);
#Obiettivo 3: massimizzare anticipo totale
#maximize z3: sum {j in J} (D[j] - (t[j]+p[j]));

#####################
data;
param nJ := 7;
param  p :=
  1   10  
  2   14  
  3   21  
  4   18  
  5    4  
  6   23  
  7   35;

param:   r       D :=
  1     15      50
  2      0      80
  3      0      95
  4     10      75
  5      5      30
  6     13     130
  7     18     120;
  
end;
