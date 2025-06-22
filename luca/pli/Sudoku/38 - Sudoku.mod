# Esercizio 38 - Sudoku

# DATI
set R := 1..9;                          # Insieme indicizzato delle righe
set C := 1..9;                          # Insieme indicizzato delle colonne
set N := 1..9;                          # Insieme indicizzato delle cifre
set MacroR := 1..3;                     # Insieme indicizzato delle macro-righe
set MacroC := 1..3;                     # Insieme indicizzato delle macro-colonne
param fix {R,C,N} binary default 0;     # Cifre fissate in input

# VARIABILI (di assegnamento)
var x {i in R, j in C,k in N} binary >= fix[i,j,k];

# VINCOLI
# Una cifra per ogni coppia (riga,colonna)
subject to Cifra {i in R, j in C}:
  sum {k in N} x[i,j,k] = 1;
# Una colonna per ogni coppia (riga,cifra)
subject to Colonna {i in R, k in N}:
  sum {j in C} x[i,j,k] = 1;
# Una riga per ogni coppia (colonna,cifra)
subject to Riga {j in C, k in N}:
  sum {i in R} x[i,j,k] = 1;
# Una volta ogni cifra in ogni macro-cella (quadrato 3x3)
subject to Quadrato {r in MacroR, c in MacroC, k in N}:
  sum {i in R, j in C: (i>=(r-1)*3+1) and (i<=r*3) and (j>=(c-1)*3+1) and (j<=c*3)} x[i,j,k] = 1;

#############

solve;

#############

printf '  *** Soluzione Sudoku *** \n\n' > "Sudoku.sol";
for {i in R}
 {for {j in C}
   {printf ' %d ', sum {k in N} k * x[i,j,k] >> "Sudoku.sol";
   }
  printf '\n' >> "Sudoku.sol";
 }
end;
