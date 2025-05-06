# Mix Produttivo Ottimale (PL-1)

# Commento OUTPUT
# VINCOLI
# La produzione ottimale � limitata dalla capacit� produttiva dei reparti Motori e Carrozzeria e
# in particolar modo dal reparto Carrozzeria dato che il suo prezzo ombra � di 420 ad unit� fino a un cambio di base.
# VARIABILI
# Nella produzione ottimale, vengono prodotte solo le vetture A e B.
# Qualora si producessero anche le vetture C, ad ogni unit� di C prodotta, il profitto possibile diminuirebbe di 200

# Rispetto ad un'oscillazione del valore dell'euro, qual'� il veicolo pi� robusto a questo cambiamento?
	# Nessun veicolo � pi� robusto dell'altro sotto questo aspetto, tutti si deprezzano o aumentano di valore contemporaneamente
# Rispetto ad oscillazioni del prezzo di ogni singolo veicolo, qual'� il veicolo pi� robusto?
	# A pu� scendere da 840 fino a 560 prima che diventi sconveniente la sua produzione, con un'oscillazione in negativo massima di ((840 - 560) / 840 =) 0.33 del suo prezzo attuale (840)
	# B pu� scendere da 1120 fino a 1020 prima che diventi sconveniente la sua produzione, con un'oscillazione in negativo massima di 0.09 del suo prezzo attuale
	# C � sconveniente da produrre se � venduta ad un prezzo inferiore a 1400
	#
	# Tra A e B, le uniche vetture prodotte, la pi� robusta ad oscillazioni del suo prezzo � A (perch� 0.33 > 0.09)

# Se si volesse risparmiare, si possono ridurre le ore disponibili ai vari reparti? Se s� quali? E di quanto?
	# S�, ma solo ai reparti i cui limiti di produzione risultano essere in base, ovvero: A B C
	# Non � possibile ridurre le ore disponibili dei reparti Motori e Carrozzeria senza influire sul profitto
	#
	# Se si vuole ridurre le ore ai vari reparti, � possibile farlo in queste quantit�:
	# A 56 (Slack) ore in meno
	# B 12 ore in meno
	# C 40 ore in meno
	#
	# Se il prezzo di ogni ora per ogni reparto fosse di 3000 � (dato non usato nel problema), quanto risparmierei rimuovendo quelle ore non necessarie?
	# 56 * 3'000 + 12 * 3'000 + 40 * 3'000 = 324'000

# Analisi Parametrica su LimiteProduzione[Carrozzeria] (cp[Carrozzeria])
# Range Ore Disponibili		Profitto
# -Inf					840
# 40					420
# 85.34 					345
# 138.67					0

# DATI
set V;					# Insieme dei Veicoli
set R;					# Insieme dei Reparti di produzione
param cp {R};			# Capacit� produttiva [h/sett]
param t {R, V};			# Tempo di lavorazione richiesto al reparto per produrre il veicolo [h/veicolo]
param p {V};			# Profitto per ogni veicolo [�/veicolo]

# VARIABILI
var x {V} >= 0;			# Unit� di veicolo prodotto alla settimana [veicolo/sett]

# VINCOLI
# Limite di produzione settimanale [h/sett]
subject to LimiteProduzione {j in R}:
	sum {i in V} x[i] * t[j, i] <= cp[j];

# OBIETTIVO
# Massimizzazione del profitto [�]
maximize z: sum {i in V} x[i] * p[i];

##############################
data;

set V := A B C;
set R := Motori Carrozzeria A B C;

param			cp :=
Motori			120
Carrozzeria		80
A				96
B				102
C				40;

param t:
				A		B		C :=
Motori			3		2		1
Carrozzeria		1		2		3
A				2		0		0
B				0		3		0
C				0		0		2;

param	p :=
A		840
B		1120
C		1200;

end;
