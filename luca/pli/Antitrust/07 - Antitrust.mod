# Esercizio Anti-trust
# DATI
set F := 1..10;             # Insieme di filiali
set P := 1..5;              # Insieme di prodotti
param a;                    # Numero di nuove aziende
set A := 1..a;              # Insieme di nuove aziende
param f {F,P};              # Fatturato di ogni fliale per ogni prodotto [k€/anno]

# VARIABILI
var x {F,A} binary;         # Assegnamento delle filiali alle nuove aziende
var delta;                  # Massimo sbilanciamento [k€/anno]

# VINCOLI
# Partizione dell'insieme delle filiali in sottinsiemi disgiunti
subject to Partizione {i in F}:
  sum {k in A} x[i,k] = 1;

# Vincoli di linearizzazione della funnzione obiettivo min-max [k€/anno]
subject to Minmax {j in P, k1 in A, k2 in A}:
  delta >= sum {i in F} f[i,j] * x[i,k1] - sum {i in F} f[i,j] * x[i,k2];
  
# OBIETTIVO
# Minimizzare il massimo sbilanciammento [k€/anno]
minimize z: delta;

####################
data;

param a:= 2;

param f :   1      2      3      4      5   :=
  1       15000  20000  18000  58000   2400
  2       20000  10000  20000  57000   1900
  3       18000  23000  17500  55500   9820
  4       21000  12000  16800  48000   6000
  5       12500  10000  10950  62000   7800
  6       13750  22000  14400  60000   2500
  7       20500  21000  21000  59800   1980
  8       14250  23800  21500  55500   3450
  9       10800  14180  25400  53250   6500
 10       13700  13980  20100  57500   4000;
 
 end;
 