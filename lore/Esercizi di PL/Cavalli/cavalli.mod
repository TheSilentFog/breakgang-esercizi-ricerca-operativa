# Esercizio Cavallli

# OUTPUT
# VINCOLI
	# VincitaMinima[c] con c Cavallo su colonna Marginal, ci indica la percentuale di puntata su ogni cavallo
	# LimiteBudget su colonna Marginal, ci indica la percentuale finale del budget nel caso vinca uno di questi cavalli
# VARIABILI
# La puntata[c] con c Cavallo su colonna Activity, ci indica quanto del budget dev'essere messo su un determinato cavallo
# vincitaMinima vincolo di uguaglianza

# SENS OUTPUT
# VINCOLI
# LimiteBudget colonne Activity e Obj Coeff, può aumentare fino all'infinito e di conseguenza anche l'obiettivo potrà aumentare all'infinito
# LimiteBudget colonna Limiting Variable, è limitato dal cavallo sul quale si punta una percentuale più alta del budget disponibile


# DATI
set Cavalli;					# Insieme dei cavalli
param quotazioni {Cavalli};		# Quotazione di ogni cavallo [u]
param budget;					# Budget complessivo da scommettere [€]

# VARIABILI
var puntata {Cavalli} >= 0;		# Quanto scommettere su ogni cavallo [€]
var vincitaMinima >= 0;

# VINCOLI
# Vincolo sul non far superare dalle puntate il budget imposto
subject to LimiteBudget:
	sum{c in Cavalli} puntata[c] <= budget;

# OBIETTIVO
maximize z: vincitaMinima;

# Vincolo di linearizzazione per obiettivo MaxMin
subject to VincitaMinima{c in Cavalli}:
	vincitaMinima <= puntata[c] * quotazioni[c];

#####################
data;

set Cavalli := Fulmine Freccia Dardo Lampo;

param quotazioni :=
Fulmine		3
Freccia		4
Dardo		5
Lampo		6;

param budget := 57;

end;
