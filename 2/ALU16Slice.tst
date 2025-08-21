load ALU16Slice.hdl;
output-file ALU16Slice.out;
compare-to ALU16Slice.cmp;
output-list zx nx zy ny f no cin x%B16.16.1 y%B16.16.1 out%B16.16.1 cout;

set zx 1; set nx 0;
set zy 1; set ny 0;
set f 1; set no 0;
set cin 0;
set x %B0000000000000000;
set y %B0000000000000000;
eval;
output;

set zx 0; set nx 0;
set zy 0; set ny 0;
set f 1; set no 0;
set x %B0000000000000011;
set y %B0000000000000010;
set cin 0;
eval;
output;

set zx 0; set nx 0;
set zy 0; set ny 0;
set f 1; set no 0;
set x %B1111111111111111;
set y %B0000000000000001;
set cin 1;
eval;
output;

set zx 0; set nx 0;
set zy 0; set ny 0;
set f 0; set no 0;
set cin 0;
set x %B1010101010101010;
set y %B0101010101010101;
eval;
output;
