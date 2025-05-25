set magazzini;
set citta;

param distanze
    {magazzini, citta} >= 0;

param terminali_da_scegliere;

var terminali
    {magazzini}
    binary;


## Solo 'terminali_da_scegliere' magazzini devono essere esattamente scelti
s.t. vincolo_scelta :
    sum{m in magazzini} terminali[m] = terminali_da_scegliere;

minimize assegna_terminali:
    sum{m in magazzini} (terminali[m] * 
            sum{destinazioni in citta} 
                distanze[m, destinazioni]);

end;
