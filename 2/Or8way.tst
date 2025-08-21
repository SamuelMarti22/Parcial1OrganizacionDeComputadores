load Or8Way.hdl;
output-file Or8Way.out;
compare-to Or8Way.cmp;
output-list in%B8.8.1 out%B1.1.1;

set in %B00000000;
eval;
output;

set in %B11111111;
eval;
output;

set in %B00010000;
eval;
output;

set in %B10000000;
eval;
output;

set in %B00100110; 
eval;
output;
