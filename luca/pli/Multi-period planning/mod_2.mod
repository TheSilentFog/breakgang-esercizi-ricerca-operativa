param periodo;
set mesi := 1 .. periodo;

param domanda {mesi};
## Unita prodotto

param capacita_produzione;
## Unita / mese

param costo_produzione;
## Euro / unita

param capacita_appalto;
## Unita / mese

param costo_appalto;
## Euro / unita

param costo_magazzino;
## Euro / unita

param capacita_iniziale;
# unita

param dimensione_lotto;

var magazzino {mesi} >= 0;
# unita

var produzione  {mesi} >= 0 integer;    # cargo
var appalto     {mesi} >= 0 integer;    # cargo

var costi       {mesi} >= 0;

s.t. limite_produzione  {m in mesi}:
    produzione[m] * dimensione_lotto <= capacita_produzione;

s.t. limite_appalto     {m in mesi}:
    appalto[m] * dimensione_lotto  <=  capacita_appalto;

s.t. soddisfacimento_domanda    {m in mesi}:
    domanda[m] <= (produzione[m] * dimensione_lotto) + (appalto[m] * dimensione_lotto) + magazzino[m];

s.t. scarto_magazzino   {m in mesi: m > 1}:
    magazzino[m] = 
    ((produzione[m]*dimensione_lotto) + (appalto[m]*dimensione_lotto) + magazzino[m-1]) - domanda[m];

s.t. magazzino_iniziale:
    magazzino[1] = 
    ((produzione[1]*dimensione_lotto) + (appalto[1]*dimensione_lotto) + capacita_iniziale) - domanda[1];

s.t. costi_mensili{m in mesi}:
    costi[m] = 
    (magazzino[m]   * costo_magazzino) + 
    (produzione[m] * dimensione_lotto * costo_produzione) + 
    (appalto[m]    * dimensione_lotto * costo_appalto);

minimize costi_periodo : sum{m in mesi} costi[m];

data;

param periodo := 3;
param domanda :=
1 100
2 130
3 150
;

param dimensione_lotto := 15;
param capacita_produzione := 110;
param costo_produzione := 300;
param capacita_appalto := 60;
param costo_appalto := 330;
param costo_magazzino := 10;
param capacita_iniziale := 0;

end;
