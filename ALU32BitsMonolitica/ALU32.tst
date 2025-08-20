load ALU32.hdl;
output-file ALU32.out;
compare-to ALU32.cmp;
output-list x%B32.32.1 y%B32.32.1 zx%B1.1.1 nx%B1.1.1 zy%B1.1.1 ny%B1.1.1 f%B1.1.1 no%B1.1.1 out%B32.32.1 zr%B1.1.1 ng%B1.1.1;


// Caso 1: suma simple sin cambios, x=1, y=1, f=1 (sum), no flags ni modificaciones
set x %B00000000000000000000000000000001;
set y %B00000000000000000000000000000001;
set zx 0; set nx 0; set zy 0; set ny 0; set f 1; set no 0;
eval;
output;

// Caso 2: suma con negación de y (nx y ny)
set x %B00000000000000000000000000000001;
set y %B00000000000000000000000000000001;
set zx 0; set nx 0; set zy 0; set ny 1; set f 1; set no 0;
eval;
output;

// Caso 3: f=0 (AND) de dos números distintos
set x %B11110000111100001111000011110000;
set y %B10101010101010101010101010101010;
set zx 0; set nx 0; set zy 0; set ny 0; set f 0; set no 0;
eval;
output;

// Caso 4: salida cero (todo cero con zx y zy activados)
set x %B10101010101010101010101010101010;
set y %B01010101010101010101010101010101;
set zx 1; set nx 0; set zy 1; set ny 0; set f 1; set no 0;
eval;
output;

// Caso 5: salida negativa (negación con no=1)
set x %B00000000000000000000000000000001;
set y %B00000000000000000000000000000001;
set zx 0; set nx 0; set zy 0; set ny 0; set f 1; set no 1;
eval;
output;
