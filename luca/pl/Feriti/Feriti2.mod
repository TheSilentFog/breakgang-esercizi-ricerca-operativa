# Esercizio PL 62 - Feriti

# DATI
param nT; # numero di triage
param nO; # numero di ospedali
param nP; # numero di tipi di paziente
set Triage   := 1..nT;
set Ospedali := 1.. nO;
set Pazienti := 1..nP;

param tempo {Triage,Ospedali};    #Tempi di percorrenza [minuti]
param capac {Pazienti,Ospedali};  # Capacità (n.pazienti di ogni tipo ricevibili da ogni ospedale)
param distr {Triage,Pazienti};    # Triage (n. pazienti di ogni tipo per ogni punto di triage) - distribuzione dei pazienti nei vari triage
param tot   {Pazienti};           # numero totale di ogni tipologia di paziente
param tmin  {t in Triage, p in Pazienti} := min {o in Ospedali: capac[p,o] > 0} (tempo[t,o]);     # tempo minimo di ricovero per ogni triage ed ogni tipo di paziente

# VARIABILI
var x {Pazienti,Triage,Ospedali} >= 0; #  numero di pazienti di ogni tipo da ogni punnto di triage inviati in ogni ospedale

# VINCOLI
# Numero di pazienti da assegnare agli ospedali
subject to Distribuzione {p in Pazienti, t in Triage}: 
  sum {o in Ospedali} x[p,t,o] = distr[t,p];

# Capacità di ogni ospedale per ogni tipo di paziente
subject to CapacitaOspedale {p in Pazienti, o in Ospedali}: 
  sum {t in Triage} x[p,t,o] <= capac[p,o];

# OBIETTIVO
# minimizzare il massivo sovraccarica tra gli ospedali
var delta;
minimize z: delta;
subject to MinMax {o in Ospedali}: (sum {t in Triage, p in Pazienti} x[p,t,o]) / (sum {t in Triage,p in Pazienti} distr[t,p] / nO) <= delta;

#############
data;

param nT:=6;
param nO:=8;
param nP:=3;

param tempo:  1   2   3   4   5   6   7   8:=
1            10  12  15  20  32  36  40  50
2            14   8   5  10  30  38  40  48
3            21  22  10  10  32  25  25  40
4            24  22  15  15  20  15  25  45
5            30  30  25  28  27  22  20  30
6            32  35  30  30  28  25  20  20;

param capac:  1   2   3   4   5   6   7   8:=
1            12  10   8  10  15  20  20  20
2             5   0   2   0   8   0   0  10
3            15   8  11   5  20  18  13   0;

param distr: 1   2   3:=
     1       3   0   5
     2      11   1   6
     3      23   9   0
     4      12   5  12
     5      19   2  19
     6      22   3  28;

param tot:=
1 90
2 20
3 70;

end;
