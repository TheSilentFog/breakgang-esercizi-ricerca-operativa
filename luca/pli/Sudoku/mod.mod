## Sudoku dei 4 serpenti
# cosa so ?
# il sudoku è una matrice 9 x 9
# ogni cella assume un solo valore da 1 a 9
# ogni righe contiene solo una apparizione del numero
# ogni colonne contiene solo una apparizione del numero
# i quadrati 3x3 contengono una sola apparizione del numero
# alcuni elementi della matrice presentano un valore prediposto immutabile

# lo scopo del gioco è scelgliere i valori mancanti della scheda 
# in modo che tutti i vincoli siano rispettati


set valori  := 1 .. 9;
set colonne := 1 .. 9;
set righe   := 1 .. 9;

param valori_predisposti {righe, colonne, valori} binary default 0;

var disposizioni {righe, colonne, valori} binary;
## Assegno ad ogni righe e colonne 
# dei valori corrispondenti al numero scelto

s.t. predisposizione{r in righe, c in colonne, v in valori}:
    disposizioni[r,c,v] >= valori_predisposti[r,c,v];

## ogni cella assume un solo valore:

s.t. unico_valore_cella {r in righe, c in colonne}:
    sum{v in valori}disposizioni[r,c,v] = 1;

## ogni riga deve contenere una sola apparizione di ogni valore
s.t. unico_valore_riga {r in righe, v in valori}:
    sum{c in colonne} disposizioni[r,c,v] = 1;

## vincolo speculare a quello sopra, ma applicato per le colonne
s.t. unico_valore_colonna {c in colonne, v in valori}:
    sum{r in righe} disposizioni[r,c,v] = 1;

s.t. q1_1{v in valori}:
    sum{r in 1..3, c in 1..3} disposizioni[r,c,v] = 1;

s.t. q1_2{v in valori}:
    sum{r in 1..3, c in 4..6} disposizioni[r,c,v] = 1;

s.t. q1_3{v in valori}:
    sum{r in 1..3, c in 7..9} disposizioni[r,c,v] = 1;


s.t. q2_1{v in valori}:
    sum{r in 4..6, c in 1..3} disposizioni[r,c,v] = 1;

s.t. q2_2{v in valori}:
    sum{r in 4..6, c in 4..6} disposizioni[r,c,v] = 1;

s.t. q2_3{v in valori}:
    sum{r in 4..6, c in 7..9} disposizioni[r,c,v] = 1;


s.t. q3_1{v in valori}:
    sum{r in 7..9, c in 1..3} disposizioni[r,c,v] = 1;

s.t. q3_2{v in valori}:
    sum{r in 7..9, c in 4..6} disposizioni[r,c,v] = 1;

s.t. q3_3{v in valori}:
    sum{r in 7..9, c in 7..9} disposizioni[r,c,v] = 1;


solve;

data;

param valori_predisposti :=

[1,1,1] 1
[1,4,2] 1

[2,2,2]1
[2,5,3]1

[3,3,4]1
[3,6,1]1

[4,3,3]1
[4,6,5]1
[4,9,6]1

[5,2,7]1
[5,8,4]1

[6,1,8]1
[6,4,9]1
[6,7,2]1

[7,1,9]1
[7,4,8]1
[7,7,7]1

[8,2,3]1
[8,5,9]1
[8,8,1]1

[9,3,2]1
[9,6,6]1
[9,9,5]1
;