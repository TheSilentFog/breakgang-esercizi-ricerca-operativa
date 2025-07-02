# Esercizio 59 - Rover su Marte

# DATI
param n;                    # Numero di siti
set Siti := 1..n;           # Insieme indicizzato dei siti
param ee {Siti};			# Consumo di energia per esplorare ogni sito [Joule]
param te {Siti};			# Consumo di tempo per esplorare ogni sito [minuti]
param valore {Siti};		# Valore di ogni sito
param K;					# Potenza consumata [Joule/minuto]
param ts {Siti,Siti};		# Consumo di tempo per ogni spostamento [minuti]
param es {i in Siti,j in Siti} := K * ts[i,j];		# Consumo di energia per ogni spostamento
param energia;				# Energia disponibile [Joule]
param tempo;				# Tempo disponibile [minuti]
param s0 in Siti;           # Sito iniziale

# VARIABILI
var y {Siti} >=0, <=1;			# Selezione siti da esplorare
var x {Siti,Siti} binary;		# Spostamenti effettuati
var e {Siti} >=0, <= energia;	# Energia consumata dopo aver raggiunto ed esplorato ogni sito
var t {Siti} >=0, <= tempo;		# Tempo consumato dopo aver raggiunto ed esplorato ogni sito

# OBIETTIVO
# Max valore osservazioni effettuate
maximize z: sum {i in Siti} valore[i] * y[i];

# VINCOLI
# Relazione tra variabili di sito y e variabili di arco x
s.t. Rel_x_y_in  {j in Siti: j<>s0}:
  y[j] = sum {i in Siti} x[i,j];
s.t. Rel_x_y_out {j in Siti: j<>s0}:
  y[j] >= sum {i in Siti} x[j,i];

# Sito s0 ha grado uscente 1 e grado entrante 0
s.t. Sito0_in:  sum {i in Siti} x[i,s0] = 0;
s.t. Sito0_out: sum {i in Siti} x[s0,i] = 1;

# No autoanelli
s.t. Loops {i in Siti}: x[i,i] = 0;

# Calcolo dei consumi di risorse (questi vincoli impediscono l'esistenza di sottocicli)
# Consumo di energia [Joule]
s.t. Consumi_e {i in Siti, j in Siti: i != j}:
  e[j] >= (e[i] + es[i,j] + ee[j]) - energia * (1 - x[i,j]);
# Consumo di tempo [minuti]
s.t. Consumi_t {i in Siti, j in Siti: i != j}:
  t[j] >= (t[i] + ts[i,j] + te[j]) - tempo * (1 - x[i,j]); 

#############################
data;

param n  := 7;
param s0 := 7;

param ts: 1   2   3   4   5   6   7 :=
1         0  13  14  16  13  13  13
2        13   0  15  14  16  14  11
3        14  15   0  15  18  13  17
4        16  14  15   0  17  16  18
5        13  16  18  17   0  18  15
6        13  14  13  16  18   0  15
7        13  11  17  18  15  15   0;
 
param K := 8;

param:	 te	ee	valore :=
1		 35	 60	  90
2		 20	 45	  50
3		 40	 70	  20
4		 60	110	 100
5		 25	 50	 120
6		 10	 25	  50
7		  0	  0	   0;

param energia := 1000;
param tempo   :=  400;

end;
