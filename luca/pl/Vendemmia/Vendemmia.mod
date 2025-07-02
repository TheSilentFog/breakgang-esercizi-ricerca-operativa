# Esercizio PL - Vendemmia

# DATI
param nV;           # Numero di vini
set V := 1..nV;     # Insieme dei vini
param nT;           # Numero di vitigni
set T := 1..nT;     # Insieme dei vitigni
param fraz {T,V};   # Composizione dei vini
param r {T};		# Quantità vendemmiata per ogni vitigno [Kg]
param k;			# Fattore di conversione da kg di uva a litri di vino [l/Kg]
param pmin {V};		# Minima % di ogni tipo di vino sul totale prodotto
param pmax {V};		# Massima % di ogni tipo di vino sul totale prodotto
param c {V};		# Valore di ogni vino [€/l];
#param cap_bott;     # Capacità delle bottiglie [l]
#param n_bott;       # Numero di bottiglie in ogni cartone

# VARIABILI
var x {V};			# Quantità di prodotto per ogni vino [Kg]
#var y {V} integer;  # Numero di cartoni di ogni tipo di vino

# VINCOLI
# Vincoli sulle quantità complessive di vitigni usati [Kg]
subject to Disponibili {t in T}:
  sum {v in V} fraz[t,v] * x[v] <= r[t];

# Vincoli sulla minime e massime percentuali di produzione [Kg]
subject to Produzione_min {v in V}:
  x[v] >= pmin[v] * sum {j in V} x[j];
subject to Produzione_max {v in V}:
  x[v] <= pmax[v] * sum {j in V} x[j];

# Vincoli sul numero di cartoni
#subject to Cartoni {v in V}:
#  x[v] = cap_bott * n_bott * y[v];

# OBIETTIVI
# Massimizzare il valore della produzione complessiva [€]
maximize z: sum {v in V} c[v] * k * x[v];

#######################
data;
param nV := 5;
param nT := 3;
param k := 0.7;

param fraz : 1   2   3   4   5 :=
1			1.0	0.3	0.0	0.0	0.0
2			0.0	0.7	1.0	0.4	0.0
3			0.0	0.0	0.0	0.6	1.0;

param r :=
1		550
2		1620
3		430;

param:	pmin	pmax	c  :=
1		0.20	0.25	10.0
2		0.15	0.20	 6.5
3		0.20	0.25	22.0
4		0.15	0.20	17.0
5		0.20	0.25	25.0;

#param cap_bott := 0.75;
#param n_bott := 12;

end;
