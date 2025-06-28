## Anti Trust
#5 prodotti
#10 filiali
#n numeri di aziende
#
#sono consciuti i fatturati di ogni prodotto per ogni filiale
#
#devo assegnare le filiali alle aziende
#
#devo minimizzare la massima differenza tra i fatturati 
#
#come minimizzo la massima differenza?
#-> guardando sulle soluzioni
#
#creo una variabile ausiliaria vincolata su 
#per ogni x1 , x2 in X
#aus  >=  x1 - x2
#    (<= ) per minimizzare

set prodotti;
set filiali := 1..10;
set aziende;

param fatturati {filiali, prodotti};

var assegna_filiale_azienda{filiali, aziende} binary;

s.t. monoassegnamento{f in filiali}:
    sum{a in aziende} assegna_filiale_azienda[f,a] = 1;

var maximized_diff >= 0;

s.t. vincolo_massimo{p in prodotti, a in aziende, b in aziende}:
    maximized_diff >= 
    (sum{f in filiali} fatturati[f,p] * assegna_filiale_azienda[f,a])
    -
    (sum{f in filiali} fatturati[f,p] * assegna_filiale_azienda[f,b]);


minimize massima_differenza_di_redditi: maximized_diff;

data;

set prodotti :=
'A'
'B'
'C'
'D'
'E'
;

set aziende :=
A1
A2;

param fatturati :
    'A'   'B'       'C'       'D'   'E' := 
1 15000 20000 18000 58000 2400
2 20000 10000 20000 57000 1900
3 18000 23000 17500 55500 9820
4 21000 12000 16800 48000 6000
5 12500 10000 10950 62000 7800
6 13750 22000 14400 60000 2500
7 20500 21000 21000 59800 1980
8 14250 23800 21500 55500 3450
9 10800 14180 25400 53250 6500
10 13700 13980 20100 57500 4000;



end;