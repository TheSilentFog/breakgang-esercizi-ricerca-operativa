# ho delle foto che vengono scattate in successione temporale
# ho inizio e fine dello scatto (possono overlappare)
# ogni foto ha un tempo di trasmissione tx e il valore di reward
# sono limitato sul tempo di trasmissione
# ha delle immagini che devono peffoza essere tramesse
#


set immagini := 0 .. 40;


param inizio        {immagini}  >= 0;
param fine          {immagini}  >= 0;

# finestra temporale di acquisizione


param tx                    {immagini}  >= 0;
param reward                {immagini}  >= 0;

# trasmissione

param capacita_tx >= 0;

param immagini_richieste    {immagini} binary;


var immagini_trasmesse      {immagini} binary;

## vincoli

## voglio che il delta di acquisizione non si sovrapponga
## con il delta di un altra immagine trasmessa

## per ogni immagine trasmessa a

s.t. overlap{a in immagini, b in immagini}:
    if ((immagini_trasmesse[a] * inizio[a]) > (immagini_trasmesse[b] * inizio[b])) then
        immagini_trasmesse[a] * inizio[a] >= immagini_trasmesse[b] * fine[b]
    else
        immagini_trasmesse[a] * fine[a] <= immagini_trasmesse[b] * inizio[b]
;

## vincolo temporale
## la somma dei tx in immagini_trasmesse deve essere leq a tempo disponibile
s.t. tempo:
    sum{i in immagini} immagini_trasmesse[i] * tx[i];

## vincolo forzature
## per ogni immagine_richiesta a
## per ogni immagini_trasmesse b
##  a <= b
s.t. forzature{i in immagini}:
    immagini_trasmesse[i] >= immagine_richiesta[i];

maximize capitalismo:
    sum{i in immagini} reward[i] * immagini_trasmesse[i];

solve;

end;
