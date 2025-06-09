set prodotti;
set materie;
set scorie;
set impianto;

param ricetta   {materie, prodotti};
param scarti    {scorie, prodotti};
param capacita  {impianto};

param budget;
param costi_trasporto   {impianto, scorie};
param costi_materie     {materie};

param profitti          {prodotti};

var produzione          {prodotti} >= 0;
var acquisto_materia    {materie} >= 0;
var avanzi_scorie       {scorie} >= 0;
var ripartizione        {impianto, scorie} >= 0;

s.t. coerenza_materiali{m in materie}:
    acquisto_materia[m] = sum{p in prodotti} ricetta[m,p] * produzione[p];

s.t. coerenza_scorie{s in scorie}:
    avanzi_scorie[s] = sum{p in prodotti} scarti[s,p] * produzione[p];

s.t. coerenza_ripartizione{s in scorie}:
    sum{i in impianto} ripartizione[i,s] = avanzi_scorie[s];

s.t. bound_ripartizione_impianto{i in impianto}:
    sum{s in scorie} ripartizione[i,s] <= capacita[i];

s.t. bound_budget:
    (sum{i in impianto}sum{s in scorie} (ripartizione[i,s]*costi_trasporto[i,s])) +
    (sum{m in materie} acquisto_materia[m] * costi_materie[m])
    <= budget;

maximize fatturato:
    sum{p in prodotti} produzione[p] * profitti[p];

solve;

end;
