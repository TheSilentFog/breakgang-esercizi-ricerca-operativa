# Generalized assignment problem

# DATA
param N;					# Numero di jobs
set Jobs := 1..N;			# Insieme indicizzato di jobs
param M;					# Numero di macchine
set Machines := 1..M;		# Insieme indicizzato di macchine
param b {Machines};			# Tempo disponibile [min]
param t {Jobs,Machines};	# Tempo di esecuzione [min]
param c {Jobs,Machines};	# Costo di assegnamento [€]

# VARIABILI
var x {Jobs,Machines} binary;	# Assegnamento

# VINCOLI
# Vincoli di assegnamento per ogni job
subject to Assignment {j in Jobs}:
  sum {m in Machines} x[j,m] = 1;
  
# Vincoli di capacità per ogni macchina
subject to Capacity {m in Machines}:
  sum {j in Jobs} t[j,m] * x[j,m] <= b[m];

# OBIETTIVO
# Minimizzare il costo totale
minimize z: sum {j in Jobs,m in Machines} c[j,m] * x[j,m];

####################
data;

param N := 9;
param M := 3;

param b :=
1		380
2		360
3		350;

param t: 1   2   3 :=
1	    100	102	 97	
2	    111	110	113	
3	     98	103	 96	
4	    132	130	135	
5	    120	123	117	
6	    115	112	118	
7	    142	145	140	
8	    123	120	125	
9	     90	 93	 88;

param c: 1	2	3 :=
1		24	42	23
2		30	45	23
3		33	54	16
4		37	45	18
5		34	47	22
6		31	42	25
7		30	41	19
8		28	47	15
9		25	50	20;


end;
