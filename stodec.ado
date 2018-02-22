
**********************************
*** written by Maik Hamjediers ***
***** last update 20.06.2016 *****
**********************************

cap program drop stodec

program stodec

syntax varlist

foreach var of local varlist {

quietly: tab `var'
local N_level = `r(r)'

foreach level of numlist 1(1) `N_level' {
if `level' != `N_level' {

local ins = sqrt(`N_level' / (`level' + `level'^2))

quietly: levelsof `var', local(levels)

quietly: gen `var'_sdorth`level' = .
foreach l of numlist 1(1) `N_level' {
gettoken lev levels : levels
quietly: replace `var'_sdorth`level' = -`ins' if `l' < `level' & `var' == `lev'
quietly: replace `var'_sdorth`level' = `ins'*`level' if `l' == `level' & `var' == `lev'
quietly: replace `var'_sdorth`level' = 0 if `l' > `level' & `l' != `N_level' & `var' == `lev'
quietly: replace `var'_sdorth`level' = -`ins' if `l' == `N_level' & `var' == `lev'
}

}
}

}

end
exit
