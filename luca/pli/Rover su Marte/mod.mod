### ROVER 

## abbiamo delle posizioni da raggiungere (set posizioni)
## l'ultima posizione è quella di partenza
## 
## conosciamo i tempi di spostamento da una pos ad un altra
## nello spostarsi il rover consuma 8 joule al minuto.
## 
## una volta arrivato al sito va esplorato
## per ogni sito conosco
##     - il tempo di esplorazione
##     - energia impiegata per esplorare
##     - valore del esplorazione
## 
## sappiamo che l'energia totale del rover è 1000 joule
## sappiamo che abbiamo a disposizione solo 400 minuti
#
#  cosa scelgo ??

# devo scegliere quali siti osservare.
# 


param n_pos;
set posizioni := 1 .. n_pos;
set viaggi := 1 .. n_pos;

param tempi_spostamento{posizioni, posizioni};  #minuto
param consumo_energia;                          #joule/minuto

param tempi_esploro{posizioni};                 #minuto
param energia_esploro{posizioni};               #joule
param valore_esploro{posizioni};                # monete?

param energia_totale;                           #joule
param tempo_totale;                             #minuti

var osservazioni    { viaggi , posizioni, posizioni} binary;
    ## primo parametro è il numero del viaggio
    ## secondo e tercero rappresentano partenza , arrivo
    ## ogni elemento è indicato come {ordine, partenza, arrivo}
    ## il primo viaggio deve essere (1, n_pos, {p in pos}) perche parto da li
s.t. vincolo_viaggio{v in viaggi}:
    sum{partenze in posizioni} 
        sum{arrivi in posizioni}
            tempi_spostamento[v, partenze, arrivi] = 1;


s.t. primo_viaggio:
    sum{p in posizioni} osservazioni[1, n_pos, p] = 1;

s.t. n_viaggio{v in viaggio, partenza in posizioni: n > 1}:
    sum{arr in posizioni} osservazioni[v, partenza, arr] = 
    sum{par in posizioni} osservazioni[v-1, par, partenza];

    ## primo componente è 1 se il viaggio attuale 
    #   parte da una posizione nota (partenza) e arriva ad arr
    ## il secondo è 1 se il viaggio precedente è 
    # partito da una qualsiasi posizione ed è arrivato alla partenza
    
    # il che implica che il rover ora si trovi a partenza e 
    # quindi possa partire da li verso una qualsiasi destinazione

