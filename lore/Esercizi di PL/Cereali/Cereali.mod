# Cereali  (PL-3)

# DATI
set L;				# Lotti di terreno
param nC;			# Numero di cereali
set C := 1..nC;		# Insieme indicizzato dei cereali
param s {L, C};		# Fabbisogno di superficie per ogni lotto e ogni cereale [acri/q]
param h {C};		# Fabbisogno di acqua per ogni cereale [m^3/q]
param a {L};		# Area disponibile su ogni lotto [acri]
param w;			# Acqua disponibile [m^3]
param p {C};		# Profitti unitari per ogni cereale [€/q]

# VARIABILI
var x {L, C} >= 0;		# Produzione [q]

# VINCOLI
# Consumo del terreno [acri]
subject to Terreno {l in L}:
	sum {c in C} s[l, c] * x[l, c] <= a[l];

# Consumo di acqua [m^3]
subject to Acqua:
	sum {c in C, l in L} h[c] * x[l, c] <= w;

# OBBIETTIVO
maximize z: sum {l in L, c in C} x[l, c] * p[c];


####################
data;

set L :=	A	B;
param nC := 6;

param s:		1		2		3		4		5		6	:=
A				0.02	0.03	0.02	0.016	0.05	0.04
B				0.02	0.034	0.024	0.02	0.06	0.034;

param h :=
1	120
2	160
3	100
4	140
5	215
6	180;

param a :=
A	200
B	400;

param w := 400000;

param p :=
1	 48
2	 62
3	 28
4	 36
5	122
6	 94;

end;

# Il primo terreno non è utilizzato
# Il secondo terreno è utilizzato, ma non completamente
# L'acqua è usata tutta, infatti il vincolo è fuori base
# Viene coltivato solo il cereale 5 sul lotto B
