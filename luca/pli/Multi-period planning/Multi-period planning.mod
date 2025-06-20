# Multi-period planning
# DATI
param nT;			# Numero di periodi (mesi)
set T := 1..nT;		# Periodi (mesi)
param domanda {T};	# Domanda per ogni periodo [u]
param Cap;			# Capacità produttiva [u]
param Costo;		# Costo unitario di produzione [€/u]
param Cap_extra;	# Capacità produttiva extra [u]
param Costo_extra;	# Costo unitario di produzione extra [€/u]
param c_giac;		# Costo di giacenza [€/um] 
param g_iniz;		# Giacenza iniziale [u]
param lotto;		# Dimensione di ogni lotto [u]

# VARIABILI
var x {T}  integer >=0, <= floor(Cap/lotto);			# Produzione in ogni mese [lotti]
var xe {T} integer >=0, <= floor(Cap_extra/lotto);		# Produzione extra in ogni mese [lotti]
var g {T}  >=0;									# Giacenza alla fine di ogni mese [u]

# VINCOLI
# Soddisfacimento della domanda [u]
subject to Domanda {t in T: t>1}: 
  g[t-1] + (x[t] + xe[t]) * lotto = domanda[t] + g[t];   
subject to Domanda1:
  g_iniz + (x[1] + xe[1]) * lotto = domanda[1] + g[1];

# Formulazione n.2
#subject to Domanda2 {t in T}:
#  g_iniz + sum {i in T: i<=t} (x[i] + xe[i]) * lotto >= sum {i in T: i<=t} domanda[i];
 
# OBIETTIVO
# Minimizzare i costi [€]
minimize z: sum {t in T} ( Costo*x[t]*lotto + Costo_extra*xe[t]*lotto + c_giac*g[t] );

#########################
data;

param nT := 3;

param domanda :=
1 100
2 130
3 150;

param Cap := 110;
param Costo := 300;
param Cap_extra := 60;
param Costo_extra := 330;

param c_giac := 10;
param g_iniz := 0;

param lotto := 15;
end;

