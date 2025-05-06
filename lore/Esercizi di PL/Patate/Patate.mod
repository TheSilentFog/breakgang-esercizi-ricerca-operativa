# Patate  (PL-2)

# Tante variabili quante sono i fornitori
# Variabili non negative perchè non esistono quantità negative
# Tableau 3 righe e 5 colonne (2 di slack)

# Uno zero sulle righe ci dice che il problema è degenere,
# Uno zero sulle colonne ci dice che ci sono ottimi multipli
# I due sono duali, nel problema duale si invertono

# Nel Risultato
# 4 Righe, vincoli + obiettivo
# 2 colonne variabili
# Preprocessing, riduce il numero di righe e colonne
# Lo scaling cerca di ottimizzare le unità di misura
# Se il min e il max hanno unità di misura comparabili: decine con decine per esempio
# Dobbiamo controllarlo noi
# Vincoli
# N non in base
# 	NU perchè non in base e pari all'upper bound
# B in Base
# Variabili
# 	NL perchè non in base e pari al lower bound

# I costi ridotti sono i numeri che troveremmo sulla riga 0 del tableau
# Le variabili e vincoli in base hanno costo ridotto pari a 0
# Le variabili e vincoli fuori base hanno costo ridotto diverso da 0 e positivo
# Se fosse negativo, si potrebbe migliorare ulteriormente l'obiettivo
# Essere fuori base e avere costo ridotto (Marginal) pari a <eps significa che ha costo ridotto quasi pari a 0
# e quindi siamo in presenza di ottimi multipli

# Discutere l'ottimalità significa dire se il modello ci garantisce se il risultato è un ottimo
# Discutere l'unicità significa dire se ci sono multipli ottimi per quel problema

# DATI
param nF;				# Numero di fornitori
set F := 1..nF;			# Insieme dei fornitori
set P;			# Insieme dei prodotti
param a {F, P};			# Resa di ogni fornitore [%]
param c {F};			# Profitto unitario per ogni fornitore [€/kg]
param b {P};			# Massima produzione consentita per ogni prodotto [kg]

# VARIABILI
var x {F} >= 0;			# Quantità rifornite [kg]

# VINCOLI
# Vincoli sulla massima produzione consentita per ogni prodotto [KG]
subject to Produzione {p in P}:
	sum {f in F} a[f, p] * x[f] <= b[p];

# OBIETTIVO
# Massimizzazione profitto totale [€]
maximize z: sum {f in F} c[f] * x[f];

######################
data;

param nF := 2;
set P := A B C;
# Matrice
param a:	A	B	C :=		# Erano [%]
1			.20	.20	.30
2			.30	.10	.30;

param c :=			# Erano [cent]
1	0.02
2	0.03;

param b :=			# Erano [tonn]
A		6000
B		4000
C		8000;

end;


# Convetire sempre tutto nelle unità di misura dello stesso ordine per tipo
# E tenerne conto mentre si inseriscono i dati nel modello
