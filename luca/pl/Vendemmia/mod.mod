# maximize alcolismo


param nVini;
param nUve;
set vini := 1..nVini;
set uve := 1..nUve;

param coefficenti_vinifici{uve, vini};      #litri / litri
param uva_raccolta{uve};                    #kg
param valore_vino{vini};                    #euro / litri
param uvificazione;                         #kg / litri
param min_prod{vini};                        # %
param max_prod{vini};                        # %

var produzione{vini} >= 0;                  # litri

s.t. vincolo_produzione{u in uve}:
    sum{v in vini} produzione[v] * coefficenti_vinifici[u,v]
    <= uva_raccolta[u] * uvificazione;

s.t. vincolo_produzione_perc_low{v in vini}:
    produzione[v] >= (sum{vin in vini} produzione[vin]) * min_prod[v];

s.t. vincolo_produzione_perc_upp{v in vini}:
    produzione[v] <= (sum{vin in vini} produzione[vin]) * max_prod[v];

maximize alcolismo:
    sum{v in vini} produzione[v] * valore_vino[v];

data;

param nVini := 5;
param nUve  := 3;

param coefficenti_vinifici :
    1   2   3   4   5 :=
1 1.0 0.3 0.0 0.0 0.0
2 0.0 0.7 1.0 0.4 0.0
3 0.0 0.0 0.0 0.6 1.0
;

param uva_raccolta :=
1 550
2 620
3 430
;


param valore_vino :=
1 10.0
2 6.5
3 22.0
4 17.0
5 25.0
;

param min_prod :=
1 0.20 
2 0.15 
3 0.20 
4 0.15 
5 0.20
;

param max_prod :=
1 0.25 
2 0.20
3 0.25 
4 0.20 
5 0.25
;

param uvificazione := 0.7;