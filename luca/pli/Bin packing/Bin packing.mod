# Bin packing

# DATI
param n;		# Numero di oggetti
set N := 1..n;	# Insieme indicizzato delgi oggetti da trasportare
param m;		# Numero di contenitori
set M := 1..m;	# Insieme indicizzato dei contenitori
param a {N};	# Peso degli oggetti [kg]
param b;		# Capacità dei contenitori [kg]

# VARIABILI
var x {N,M} binary;	# Assegnamento degli oggetti ai contenitori
var y {M}   binary;	# Selezione dei contenitori

# VINCOLI
# Vincoli di assegnamento
subject to Assegnamento {i in N}: 
  sum {j in M} x[i,j] = 1;

# Vincoli di capacità [kg]
subject to Capacity {j in M}: 
  sum {i in N} a[i] * x[i,j] <= b * y[j];

# OBIETTIVO
# Minimizzare il numero di contenitori usati
minimize z: sum {j in M} y[j];

#################################
data;

param n := 20;
param m :=  5;
param b := 700;
param a :=
 1		144 
 2		172 
 3		153 
 4		131 
 5		126 
 6		109 
 7		165 
 8		149 
 9		108 
10		 84 
11		199 
12		160 
13		182 
14		129 
15		107 
16		161 
17		130 
18		167 
19		128 
20		 94;

end;
