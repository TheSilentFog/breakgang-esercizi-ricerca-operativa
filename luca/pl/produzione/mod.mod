set prodotti;
set mesi := 1..12;

param domanda
    {mesi, prodotti} >= 0;
#unita

param costi_produzione
    {mesi, prodotti} >= 0;
#euro/unita

param capacita_produzione
    {mesi, prodotti} >= 0;
#unita

param costi_magazzino
    {mesi} >= 0;
#euro/unita

param max_magazzino >= 0;
#unita

############################################

var magazzino
    {mesi, prodotti} >= 0;
#unita

var produzione
    {mesi, prodotti} >= 0;
#unita

############################################

s.t. soddisfacimento_domanda
        {m in mesi, p in prodotti}:
    (if m == 1 then
        produzione[m,p]
    else
        magazzino[m-1, p] + produzione[m, p] 
    ) >= domanda[m,p]
    ;

s.t. dimensionamento_magazzino
        {m in mesi,p in prodotti}:
    (if m == 1 then
        produzione[m,p] - domanda[m,p]
    else
        magazzino[m-1, p] + produzione[m,p] - domanda[m, p]
    ) = magazzino[m,p];

s.t. limite_magazzino{m in mesi}:
    sum{p in prodotti} magazzino[m, p] <= max_magazzino;

s.t. limite_produzione{m in mesi, p in prodotti}:
    produzione[m,p] <= capacita_produzione[m,p];

###################################

minimize costi:
    sum{m in mesi}
        sum{p in prodotti}(
            magazzino[m,p] * costi_magazzino[m] +
            produzione[m,p] * costi_produzione[m,p]);

solve;
end;
