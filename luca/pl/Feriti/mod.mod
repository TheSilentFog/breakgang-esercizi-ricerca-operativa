# Feriti
# Dati

 ## ci sono 3 tipologie di Feriti
 ## conosciamo quanti feriti per ogni tipologia e in che triage si trovano
 ## 
 ## ci sono n ospedali della zona
 ## conosciamo le capacita per ogni tipo di ferito
 ## 
 ## ci sono dei punti di triage
 ## conosciamo i tempi di percorrenza da ogni punto agli ospedali
 ## 
 ## vogliamo scegliere quanti pazienti di un tipo mandare da un triage ad un ospedale
 ## 


param nTip;
set tipologie := 1 .. nTip;
param nTriage;
set triage := 1 .. nTriage;
param nOspedali;
set ospedali := 1 .. nOspedali;

param feriti {tipologie, triage};
param capacita {tipologie, ospedali};
param distanze {triage, ospedali};


param min_d {t in tipologie, tr in triage} := min{o in ospedali : capacita[t, o] > 1} distanze[tr, o];

var partizionamento {t in tipologie, tr in triage, o in ospedali} 
>= 0;

s.t. ridistribuizione {t in tipologie, tr in triage}:
    feriti[t, tr] = 
    sum{o in ospedali} partizionamento[t, tr, o];


s.t. limite_ospedale {t in tipologie, o in ospedali}:
    sum{tr in triage} partizionamento[t, tr, o] <= capacita[t, o];

## obiettivo

# minimizzare il ritardo relativo medio ?
# il valore medio del ritardo relativo della popolazione
# il ritardo relativo è il rapporto tra 
# -> trasporto_assegnato / minimo trasporto esistente

minimize obj :  sum{t in tipologie, tr in triage, o in ospedali} 
                ((distanze[tr, o] / min_d[t, tr]) * partizionamento[t, tr, o])
                /
                sum{t2 in tipologie, tr2 in triage} feriti[t2, tr2];

data;

param nTip := 3;
param nTriage := 6;
param nOspedali := 8;

param distanze :
1 2 3 4 5 6 7 8 :=
1 10 12 15 20 32 36 40 50
2 14 8 5 10 30 38 40 48
3 21 22 10 10 32 25 25 40
4 24 22 15 15 20 15 25 45
5 30 30 25 28 27 22 20 30
6 32 35 30 30 28 25 20 20;

param capacita :
1 2 3 4 5 6 7 8 :=
1 12 10 8 10 15 20 20 20
2 5 0 2 0 8 0 0 10
3 15 8 11 5 20 18 13 0
;

param feriti : 
1 2 3 4 5 6 :=
1 3 11 23 12 19 22
2 0 1 9 5 2 3
3 5 6 0 12 19 28;