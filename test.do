
clear all
set obs 6
gen id = _n
drop if id == 5
expand 2 if id < 10
gen random = uniform()
sort random

stodec id
sort id
