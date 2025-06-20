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

var magazzino {mesi} >= 0;
# unita

var produzione  {mesi} >= 0;
var appalto     {mesi} >= 0;

var costi       {mesi} >= 0;

s.t. limite_produzione  {m in mesi}:
    produzione[m] <= capacita_produzione;

s.t. limite_appalto     {m in mesi}:
    appalto[m]  <=  capacita_appalto;

s.t. soddisfacimento_domanda    {m in mesi}:
    domanda[m] <= produzione[m] + appalto[m] + magazzino[m];

s.t. scarto_magazzino   {m in mesi: m > 1}:
    magazzino[m] = 
    (produzione[m-1] + appalto[m-1] + magazzino[m-1]) - domanda[m-1];

s.t. magazzino_iniziale:
    magazzino[1] = capacita_iniziale;

s.t. costi_mensili{m in mesi}:
    costi[m] = 
    (magazzino[m]   * costo_magazzino) + 
    (produzione[m]  * costo_produzione) + 
    (appalto[m]     * costo_appalto);

minimize costi_periodo : sum{m in mesi} costi[m];

data;

param periodo := 4;
param domanda :=
1 100
2 130
3 150
4 200
;

param capacita_produzione := 110;
param costo_produzione := 300;
param capacita_appalto := 60;
param costo_appalto := 330;
param costo_magazzino := 10;
param capacita_iniziale := 0;

end;
