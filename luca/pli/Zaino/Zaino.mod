# Esercizio Zaino
# DATI
param n;            # Numero oggetti
set N := 1..n;      # Insieme oggetti
param a {N};        # Volumi
param c {N};        # Valori
param b;            # Capacità

# VARIABILI
#var x {N} >=0;                 # Quantità continue di sostanze
#var x {N} >=0, integer;        # Numero di confezioni indivisibili
var x {N} binary;   # Selezione oggetti

# VINCOLI
# Vincolo di capacità
subject to Capacity:
  sum {i in N: x[i]=1} a[i] <= b;
  
# OBIETTIVO
# Massimizzare valore complessivo
maximize z: sum {i in N} c[i] * x[i];

#################
data; 

param n := 12;

param: a    c  := 
 1	  41	16 
 2	  39	19 
 3	  45	19 
 4	  28	12 
 5	  56	22 
 6	  58	29 
 7	  37	18 
 8	  63	26 
 9	  49	22 
10	  33	14 
11	  42	19 
12	  52	25;

param b := 300;

end;
