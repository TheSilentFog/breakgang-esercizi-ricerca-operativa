set valori := 0..9;
set posizione := 1..10;
set indizzi := 1..4;

param  numeri_indizzi{indizzi,posizione, valori} binary default 0;

var numero_magico {posizione, valori} binary;

## tutti i numeri sono diversi
# per ogni valore la somma in ogni posizione deve essere = 1
s.t. no_ripetizioni{v in valori}:
    sum{p in posizione} numero_magico[p,v] = 1;

s.t. one_per_pos{p in posizione}:
    sum{v in valori} numero_magico[p,v] = 1;


## ho degli indizzi:
# nel primo sappiamo due cifre del numero in per in posizione errata
# la somma del prodotto tra i magici e inidizio deve essere = 10 - 2
s.t. primo_indizio:
    sum{p in posizione, v in valori} numero_magico[p,v] * numeri_indizzi[1,p,v] = 8;

s.t. secondo_indizio:
    sum{p in posizione, v in valori} numero_magico[p,v] * numeri_indizzi[2,p,v] = 2;

s.t. terzo_indizio:
    sum{p in posizione, v in valori} numero_magico[p,v] * numeri_indizzi[3,p,v] = 1;

s.t. quarto_indizio:
    sum{p in posizione, v in valori} numero_magico[p,v] * numeri_indizzi[4,p,v] = 4;

solve;


# Example of a for loop in GMPL (MathProg)
printf "Numero magico:\n";
for {p in posizione} {
    printf "%d;", sum{v in valori} (numero_magico[p,v] * v);
}
printf "\n";

data;







param numeri_indizzi:=
[1,1,2]1
[1,2,4]1
[1,3,5]1
[1,4,3]1
[1,5,1]1
[1,6,6]1
[1,7,9]1
[1,8,0]1
[1,9,8]1
[1,10,7]1

[2,1,6]1
[2,2,8]1
[2,3,7]1
[2,4,1]1
[2,5,2]1
[2,6,0]1
[2,7,9]1
[2,8,4]1
[2,9,3]1
[2,10,5]1

[3,1,3]1
[3,2,0]1
[3,3,9]1
[3,4,2]1
[3,5,1]1
[3,6,8]1
[3,7,4]1
[3,8,5]1
[3,9,7]1
[3,10,6]1


[4,1,2]1
[4,2,4]1
[4,3,1]1
[4,4,3]1
[4,5,0]1
[4,6,8]1
[4,7,9]1
[4,8,5]1
[4,9,7]1
[4,10,6]1
;