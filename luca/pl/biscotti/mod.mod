set biscotti;
set ingredienti;

param ricetta
	{ingredienti, biscotti} >= 0;
	# unita percentuali

param tempi
	{biscotti} >= 0;
	# kg producibili / giorno

param guadagni
	{biscotti} >= 0;
	# euro / kg

param costi
	{ingredienti} >= 0;
	# euro / kg

param minimo_ingredienti
	{ingredienti} >= 0;
	# kg / settimana
	
param minimo_produzione 
	{biscotti}    	>= 0;
	# kg / settimana
param massimo_produzione
	{biscotti} 	>= 0;
	# kg / settimana

param budget >= 0;				# euro
param tempo_disponibile >= 0; 	# settimane
param giorni_lavorativi := 5;	# giorni
# non siamo la fabbrica di TEMU
param costo_campagna >= 0;		# euro

var produzione{biscotti} >= 0;
var impiego{ingredienti} >= 0;
var tempo_nel_forno{biscotti} >= 0;

s.t. produzione_min
	{b in biscotti}:
	produzione[b] >= minimo_produzione[b] * tempo_disponibile;
s.t. produzione_max
	{b in biscotti}:
	produzione[b] <= massimo_produzione[b] * tempo_disponibile;

## Pruduzione interna a min-max

s.t. impiego_ricetta
	{i in ingredienti}:
	sum{b in biscotti} produzione[b] * (ricetta[i, b]/100) <= impiego[i];

## Coerenza ingredienti / produzione

s.t. impiego_minimo
	{i in ingredienti}:
	impiego[i] >= minimo_ingredienti[i]*tempo_disponibile;

## Limite inferiore per ingredienti

s.t. tempi_lavoro{b in biscotti}:
	produzione[b] / tempi[b] = tempo_nel_forno[b];

	## kg / (kg/giorno) = giorni
## Coerenza produzione con uso dell'impianto

s.t. limite_tempo_nel_forno:
	sum{b in biscotti} tempo_nel_forno[b] <= tempo_disponibile * giorni_lavorativi;
	
	## somma dei giorni di uso del forno per il biscotto x deve essere minore dei giorni dei giorni disponibili
## Limite superiore per uso del forno

s.t. budget_cap:
	sum{i in ingredienti} (impiego[i] * costi[i]) <= budget;

## Limite superiore per l'acquisto degli ingredienti


maximize felicita:
	sum{b in biscotti} produzione[b] * guadagni[b] - sum{i in ingredienti} (impiego[i] * costi[i]);

solve;
end;
