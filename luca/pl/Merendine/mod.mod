set prodotti;
set ingredienti;
set dimensioni := {'piccole', 'grandi'};

param vendita_merendine{prodotti} >= 0;
# euro/kg

param composizione{ingredienti, prodotti} >= 0;
# %

param disponibilita_ingredienti {ingredienti} >= 0;
# Kg

var produzione {prodotti} >= 0;
# Kg Biscotti

var consumo_ingredienti {ingredienti} >= 0;
# Kg ingredienti

var scatole{dimensioni, prodotti} >= 0;
# kg biscotti

s.t. coerenza_produzione_ingredienti{i in ingredienti}:
    consumo_ingredienti[i] = sum{p in prodotti} (produzione[p] * (composizione[i,p] / 100));

s.t. coerenza_produzione_scatole{p in prodotti}:
    sum{d in dimensioni} scatole[d,p] = produzione[p];

## uso tutte le risorse disponibili e non ne invento
s.t. limite_ingredienti{i in ingredienti}:
    consumo_ingredienti[i] <= disponibilita_ingredienti[i];

## biscotti speciali devono essere compresi tra 10% e 25% dei normali
s.t. produzione_vincolata_lw:
     produzione['biscotti speciali'] >= 0.10 * produzione['biscotti normali'];
s.t. produzione_vincolata_up:
    produzione['biscotti speciali'] <= 0.25 * produzione['biscotti normali'];


## gli avanzi non devono essere piu del 10% dei totali degli ingredienti
s.t. avanzi{sp in {'zucchero','marmellata','cioccolato'}}:
    disponibilita_ingredienti[sp] * 0.10 >= disponibilita_ingredienti[sp] - consumo_ingredienti[sp] ;


## i prodotti in scatole grandi devono essere compresi 
#   tra il 40% e il 60% della produzione di quel prodotto
s.t. ripartizione_scatole_lw{p in prodotti}: 
    scatole['grandi', p]
    >=
    0.40 * produzione[p]
    ;

s.t. ripartizione_scatole_up{p in prodotti}:
    scatole['grandi', p] 
    <= 
    0.60 * produzione[p];


## il totale dei prodotti in scatole grandi deve essere compreso 
#   tra il 40% e il 60% della produzione del totale
s.t. ripartizione_scatole_totali_lw:
    sum{p in prodotti} scatole['grandi', p]
    >=
    0.40 * sum{p in prodotti} produzione[p] 
    ;

s.t. ripartizione_scatole_totali_up:
    sum{p in prodotti} scatole['grandi', p] 
    <= 
    0.60 * sum{p in prodotti} produzione[p];


## ogni prodotto deve essere almeno il 10% della produzione totale
s.t. ripartizione_produzione_totale{p in prodotti}:
    produzione[p] >= 0.10 * sum{t in prodotti} produzione[t];

maximize profitto:
    sum{p in prodotti} produzione[p] * vendita_merendine[p];


solve;
end;
