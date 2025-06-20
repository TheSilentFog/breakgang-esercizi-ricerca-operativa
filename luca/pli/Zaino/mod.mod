## ZAINO

set oggetti;

param volume    {oggetti};  # Litri / kg
param valore    {oggetti};  # euro  / kg
param capacitad;            # litri

var zaino       {oggetti} >= 0; # kg

s.t. max_zaino:
    sum{o in oggetti} zaino[o] * volume[o] <= capacitad;

maximize guadagno: sum{o in oggetti} zaino[o] * valore[o];

# V1


data;
set oggetti := 
Obj1
Obj2
Obj3
Obj4
Obj5
Obj6
Obj7
Obj8
Obj9
Obj10
Obj11
Obj12
;

param volume := 
Obj1   41
Obj2   39
Obj3   45
Obj4   28
Obj5   56
Obj6   58
Obj7   37
Obj8   63
Obj9   49
Obj10  33
Obj11  42
Obj12  52
;

param valore := 
Obj1   16
Obj2   19
Obj3   19
Obj4   12
Obj5   22
Obj6   29
Obj7   18
Obj8   26
Obj9   22
Obj10  14
Obj11  19
Obj12  25
;

param capacitad := 300;

end;
