# 
param n_oggetti;
param n_container;      ##  espresso in quantita numeriche



set oggetti := 1..n_oggetti;
set container := 1.. n_container;


param peso {oggetti};   ##  espresso in kg

param capacita;         ##  espressa in kg, capacita' massima di un container


var posizionamento {oggetti, container} binary;
var container_usato {container} binary;



s.t. mono_contanier{o in oggetti}:
    sum{c in container} posizionamento[o,c] = 1;

s.t. limite_capacita{c in container}:
    sum{o in oggetti} posizionamento[o,c] * peso[o] <= capacita * container_usato[c];

#   *contare i container usati*
#   utilizzo la capacita totale:
#   sum{c in container} capacita * container_usato[c]
#   questa proprieta mi permette di lasciar scegliere al solutore se attivare o disattivare il cargo
#   disattivato => azzerare la sua capacita potenziale

minimize utilizzo_container_totali: sum{c in container} container_usato[c] ;

####################
data;

param n_oggetti := 20; 

param n_container := 5;

param capacita := 700;


param peso :=
1 144
2 172
3 153
4 131
5 126
6 109
7 165
8 149
9 108
10 84
11 199
12 160
13 182
14 129
15 107
16 161
17 130
18 167
19 128
20 94
;