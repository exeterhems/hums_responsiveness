* SYNTAX FOR LONGITUDINAL ANALYSIS OF HSV AND WELLBEING DATA - Output tables
* Amy Heather July 2021

version 15.1
cd "S:\ExeterWellbeingValue - Well being and Value - Exeter"

use "HUMS Workstream 2 Phase 3\PHASE 1 2 AND 3 DATA LongitudinalGroups.dta", replace

****************************************************************************************************
* Amendment to putexcel to prevent it from creating an error when doing multiple putexcel in a loop and running too slow
****************************************************************************************************
capture program drop putexcel_wait
program define putexcel_wait
	*** Try the putexcel statement, capturing the results if there is an error
	capture putexcel `0'
	*** If the error was becausel putexcel was unable to save the file, then wait 1000ms then try again
	if _rc == 603 {
		sleep 1000
		putexcel `0'
	}
	*** If there was a different error, then run the putexcel file again immeditaely and display the error message
	else if _rc != 0 {
		putexcel `0'
	}
end

****************************************************************************************************
* Descriptive statistics at baseline, timepoint 1 and timepoint 2 for respondents 
* (1) with all data for PBMs and wellbeing measures analysis
* (2) and for full sample (i.e. if they have at least 1 PBM with 2 consecutive responses, they're included in sample)
****************************************************************************************************
* Create variable indicating, for each ID, if they have at least 1 PBM with 2 consecutive responses
gen consec = 0
replace consec = 1 if !mi(W00_EQ5D_HSV) & !mi(FU1_EQ5D_HSV)
replace consec = 1 if !mi(FU1_EQ5D_HSV) & !mi(FU2_EQ5D_HSV)
replace consec = 1 if !mi(W00_MSIS_8D) & !mi(FU1_MSIS_8D)
replace consec = 1 if !mi(FU1_MSIS_8D) & !mi(FU2_MSIS_8D)
replace consec = 1 if !mi(W00_MSIS_8D_P) & !mi(FU1_MSIS_8D_P)
replace consec = 1 if !mi(FU1_MSIS_8D_P) & !mi(FU2_MSIS_8D_P)
replace consec = 1 if !mi(W00_ASCOT_WBV) & !mi(FU1_ASCOT_WBV)
replace consec = 1 if !mi(FU1_ASCOT_WBV) & !mi(FU2_ASCOT_WBV)
replace consec = 1 if !mi(W00_ICECAP_A_WBV) & !mi(FU1_ICECAP_A_WBV)
replace consec = 1 if !mi(FU1_ICECAP_A_WBV) & !mi(FU2_ICECAP_A_WBV)

* Total number of people
sum UserId if consec==1

local sumvar W00_Age W00_MSIS29_phys W00_MSIS29_psyc W00_MSWS12_tot_r W00_HADS_depression ///
	W00_HADS_anxiety W00_FSS_tot W00_EQ5D_HSV W00_MSIS_8D W00_MSIS_8D_P W00_ASCOT_WBV W00_ICECAP_A_WBV ///
	FU1_Age FU1_MSIS29_phys FU1_MSIS29_psyc FU1_MSWS12_tot_r FU1_HADS_depression ///
	FU1_HADS_anxiety FU1_FSS_tot FU1_EQ5D_HSV FU1_MSIS_8D FU1_MSIS_8D_P FU1_ASCOT_WBV FU1_ICECAP_A_WBV ///
	FU2_Age FU2_MSIS29_phys FU2_MSIS29_psyc FU2_MSWS12_tot_r FU2_HADS_depression ///
	FU2_HADS_anxiety FU2_FSS_tot FU2_EQ5D_HSV FU2_MSIS_8D FU2_MSIS_8D_P FU2_ASCOT_WBV FU2_ICECAP_A_WBV
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("Sum") replace
putexcel_wait A1 = ("Variable")
putexcel_wait B1 = ("Obs")
putexcel_wait C1 = ("Mean")
putexcel_wait D1 = ("SD")
putexcel_wait E1 = ("Min")
putexcel_wait F1 = ("Max")
local row = 2
foreach v in `sumvar' {
	putexcel_wait A`row' = ("`v'")
	sum `v' if consec==1
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
}

* Using xttab instead of tab as it produces a matrix that can easily be exported
xtset UserId

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("Gender") modify
xttab Gender if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderW00") modify
xttab W00_Gender if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderFU1") modify
xttab FU1_Gender if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderFU2") modify
xttab FU2_Gender if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeandW00") modify
xttab W00_MSTypeNow if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeFU1") modify
xttab FU1_MSTypeNow if consec==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeFU2") modify
xttab FU2_MSTypeNow if consec==1
putexcel_wait A1 = matrix(r(results))

* Different ways at looking at MS type (above just uses baseline - and missing if they didn't report at baseline)
* Use oldest available report of MS type
gen MSTypeOldest = W00_MSTypeNow
replace MSTypeOldest = FU1_MSTypeNow if mi(MSTypeOldest)
replace MSTypeOldest = FU2_MSTypeNow if mi(MSTypeOldest)
label values MSTypeOldest mstype
* Use newest available report of MS type
gen MSTypeNewest = FU2_MSTypeNow
replace MSTypeNewest = FU1_MSTypeNow if mi(MSTypeNewest)
replace MSTypeNewest = W00_MSTypeNow if mi(MSTypeNewest)
label values MSTypeNewest mstype
* Compare
tab MSTypeOldest
tab MSTypeNewest

*Percentage at floor and ceiling
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("FloorCeiling") modify
putexcel_wait A1 = ("Variable")
putexcel_wait B1 = ("Number at floor")
putexcel_wait C1 = ("Number at ceiling")
local row = 2
local eq5d W00_EQ5D_HSV FU1_EQ5D_HSV FU2_EQ5D_HSV
foreach v in `eq5d' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec==1 & `v'==-.5939999818801879883
	putexcel_wait B`row' = (r(N))
	sum `v' if consec==1 & `v'==1
	putexcel_wait C`row' = (r(N))
	
	local ++row
}
local msis8d W00_MSIS_8D FU1_MSIS_8D FU2_MSIS_8D
foreach v in `msis8d' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec==1 & `v'==.079131193459033966
	putexcel_wait B`row' = (r(N))
	sum `v' if consec==1 & `v'==.8820801973342896
	putexcel_wait C`row' = (r(N))
	
	local ++row
}
local msis8dp W00_MSIS_8D_P FU1_MSIS_8D_P FU2_MSIS_8D_P
foreach v in `msis8dp' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec==1 & `v'==.138320103287696838
	putexcel_wait B`row' = (r(N))
	sum `v' if consec==1 & `v'==.892647683620452881
	putexcel_wait C`row' = (r(N))
	
	local ++row
}
local ascot W00_ASCOT_WBV FU1_ASCOT_WBV FU2_ASCOT_WBV
*Netten 2012 says -0.171 to 1.. is 0.999 the 1? Presuming it has to be, given the numbers.
foreach v in `ascot' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec==1 & `v'==-.170634999871253967
	putexcel_wait B`row' = (r(N))
	sum `v' if consec==1 & `v'==.998645007610321045
	putexcel_wait C`row' = (r(N))
	
	local ++row
}
local icecap W00_ICECAP_A_WBV FU1_ICECAP_A_WBV FU2_ICECAP_A_WBV
* Should range from 0 to 1... presuming -0.0010000000 has to be 0?
foreach v in `icecap' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec==1 & `v'==-.001000000513158738613
	putexcel_wait B`row' = (r(N))
	sum `v' if consec==1 & `v'==1
	putexcel_wait C`row' = (r(N))
	
	local ++row
}

****************************************************************************************************
* Descriptive statistics for T1 to T2, and then for T2 to T3 (i.e. doing each transition seperately)
****************************************************************************************************
* Generate variable to use when filtering sample for age, MS type, etc.
gen consec12 = 0
replace consec12 = 1 if !mi(W00_EQ5D_HSV) & !mi(FU1_EQ5D_HSV)
replace consec12 = 1 if !mi(W00_MSIS_8D) & !mi(FU1_MSIS_8D)
replace consec12 = 1 if !mi(W00_MSIS_8D_P) & !mi(FU1_MSIS_8D_P)
replace consec12 = 1 if !mi(W00_ASCOT_WBV) & !mi(FU1_ASCOT_WBV)
replace consec12 = 1 if !mi(W00_ICECAP_A_WBV) & !mi(FU1_ICECAP_A_WBV)
gen consec23 = 0
replace consec23 = 1 if !mi(FU1_EQ5D_HSV) & !mi(FU2_EQ5D_HSV)
replace consec23 = 1 if !mi(FU1_MSIS_8D) & !mi(FU2_MSIS_8D)
replace consec23 = 1 if !mi(FU1_MSIS_8D_P) & !mi(FU2_MSIS_8D_P)
replace consec23 = 1 if !mi(FU1_ASCOT_WBV) & !mi(FU2_ASCOT_WBV)
replace consec23 = 1 if !mi(FU1_ICECAP_A_WBV) & !mi(FU2_ICECAP_A_WBV)

* Descriptives & PROMS for T1 to T2
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("SumT12Only") modify
putexcel_wait A1 = ("Variable")
putexcel_wait B1 = ("Obs")
putexcel_wait C1 = ("Mean")
putexcel_wait D1 = ("SD")
putexcel_wait E1 = ("Min")
putexcel_wait F1 = ("Max")
local row = 2
local descprom12 W00_Age W00_MSIS29_phys W00_MSIS29_psyc W00_MSWS12_tot_r W00_HADS_depression W00_HADS_anxiety W00_FSS_tot ///
	FU1_Age FU1_MSIS29_phys FU1_MSIS29_psyc FU1_MSWS12_tot_r FU1_HADS_depression FU1_HADS_anxiety FU1_FSS_tot 
foreach v in `descprom12' {
	putexcel_wait A`row' = ("`v'")
	sum `v' if consec12 == 1
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
}

* PBMs for T1 to T2
local descpbm EQ5D_HSV MSIS_8D MSIS_8D_P ASCOT_WBV ICECAP_A_WBV
foreach v in `descpbm' {
	putexcel_wait A`row' = ("W00_`v'")
	sum W00_`v' if !mi(FU1_`v')
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
	
	putexcel_wait A`row' = ("FU1_`v'")
	sum FU1_`v' if !mi(W00_`v')
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
}

* Descriptives and PROMS for T2 to T3
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("SumT23Only") modify
putexcel_wait A1 = ("Variable")
putexcel_wait B1 = ("Obs")
putexcel_wait C1 = ("Mean")
putexcel_wait D1 = ("SD")
putexcel_wait E1 = ("Min")
putexcel_wait F1 = ("Max")
local row = 2
local descprom23 FU1_Age FU1_MSIS29_phys FU1_MSIS29_psyc FU1_MSWS12_tot_r FU1_HADS_depression FU1_HADS_anxiety FU1_FSS_tot ///
	FU2_Age FU2_MSIS29_phys FU2_MSIS29_psyc FU2_MSWS12_tot_r FU2_HADS_depression FU2_HADS_anxiety FU2_FSS_tot
foreach v in `descprom23' {
	putexcel_wait A`row' = ("`v'")
	sum `v' if consec23 == 1
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
}

* PBMs for T2 to T3
local descpbm EQ5D_HSV MSIS_8D MSIS_8D_P ASCOT_WBV ICECAP_A_WBV
foreach v in `descpbm' {
	putexcel_wait A`row' = ("FU1_`v'")
	sum FU1_`v' if !mi(FU2_`v')
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
	
	putexcel_wait A`row' = ("FU2_`v'")
	sum FU2_`v' if !mi(FU1_`v')
	putexcel_wait B`row' = (r(N))
	putexcel_wait C`row' = (r(mean))
	putexcel_wait D`row' = (r(sd))
	putexcel_wait E`row' = (r(min))
	putexcel_wait F`row' = (r(max))
	local ++row
}

* Using xttab instead of tab as it produces a matrix that can easily be exported
xtset UserId

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT12") modify
xttab Gender if consec12==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT12W00") modify
xttab W00_Gender if consec12==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT12FU1") modify
xttab FU1_Gender if consec12==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT23") modify
xttab Gender if consec23==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT23FU1") modify
xttab FU1_Gender if consec23==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("GenderT23FU2") modify
xttab FU2_Gender if consec23==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeT12andW00") modify
xttab W00_MSTypeNow if consec12==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeT12FU1") modify
xttab FU1_MSTypeNow if consec12==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeT23andFU1") modify
xttab FU1_MSTypeNow if consec23==1
putexcel_wait A1 = matrix(r(results))

putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("MSTypeT23FU2") modify
xttab FU2_MSTypeNow if consec23==1
putexcel_wait A1 = matrix(r(results))

*Percentage at floor and ceiling
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\SampleDescriptives", sheet("FloorCeilingT12T23") modify
putexcel_wait A1 = ("Variable")
putexcel_wait B1 = ("T12 Number at floor")
putexcel_wait C1 = ("T12 Number at ceiling")
putexcel_wait D1 = ("T23 Number at floor")
putexcel_wait E1 = ("T23 Number at ceiling")
local row = 2
local eq5d W00_EQ5D_HSV FU1_EQ5D_HSV FU2_EQ5D_HSV
foreach v in `eq5d' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec12==1 & `v'==-.5939999818801879883
	putexcel_wait B`row' = (r(N))
	sum `v' if consec12==1 & `v'==1
	putexcel_wait C`row' = (r(N))
	
	sum `v' if consec23==1 & `v'==-.5939999818801879883
	putexcel_wait D`row' = (r(N))
	sum `v' if consec23==1 & `v'==1
	putexcel_wait E`row' = (r(N))
	
	local ++row
}
local msis8d W00_MSIS_8D FU1_MSIS_8D FU2_MSIS_8D
foreach v in `msis8d' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec12==1 & `v'==.079131193459033966
	putexcel_wait B`row' = (r(N))
	sum `v' if consec12==1 & `v'==.8820801973342896
	putexcel_wait C`row' = (r(N))
	
	sum `v' if consec23==1 & `v'==.079131193459033966
	putexcel_wait D`row' = (r(N))
	sum `v' if consec23==1 & `v'==.8820801973342896
	putexcel_wait E`row' = (r(N))
	
	local ++row
}
local msis8dp W00_MSIS_8D_P FU1_MSIS_8D_P FU2_MSIS_8D_P
foreach v in `msis8dp' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec12==1 & `v'==.138320103287696838
	putexcel_wait B`row' = (r(N))
	sum `v' if consec12==1 & `v'==.892647683620452881
	putexcel_wait C`row' = (r(N))
	
	sum `v' if consec23==1 & `v'==.138320103287696838
	putexcel_wait D`row' = (r(N))
	sum `v' if consec23==1 & `v'==.892647683620452881
	putexcel_wait E`row' = (r(N))
	
	local ++row
}
local ascot W00_ASCOT_WBV FU1_ASCOT_WBV FU2_ASCOT_WBV
*Netten 2012 says -0.171 to 1.. is 0.999 the 1? Presuming it has to be, given the numbers.
foreach v in `ascot' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec12==1 & `v'==-.170634999871253967
	putexcel_wait B`row' = (r(N))
	sum `v' if consec12==1 & `v'==.998645007610321045
	putexcel_wait C`row' = (r(N))
	
	sum `v' if consec23==1 & `v'==-.170634999871253967
	putexcel_wait D`row' = (r(N))
	sum `v' if consec23==1 & `v'==.998645007610321045
	putexcel_wait E`row' = (r(N))
	
	local ++row
}
local icecap W00_ICECAP_A_WBV FU1_ICECAP_A_WBV FU2_ICECAP_A_WBV
* Should range from 0 to 1... presuming -0.0010000000 has to be 0?
foreach v in `icecap' {
	putexcel_wait A`row' = ("`v'")
	
	sum `v' if consec12==1 & `v'==-.001000000513158738613
	putexcel_wait B`row' = (r(N))
	sum `v' if consec12==1 & `v'==1
	putexcel_wait C`row' = (r(N))
	
	sum `v' if consec23==1 & `v'==-.001000000513158738613
	putexcel_wait D`row' = (r(N))
	sum `v' if consec23==1 & `v'==1
	putexcel_wait E`row' = (r(N))
	
	local ++row
}

****************************************************************************************************
* Mean scores, mean change, t-test, SRM, SES
****************************************************************************************************
* Set up and label excel spreadsheet
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\FullResultsTable", sheet("Main") replace
putexcel_wait A1 = ("Group")
putexcel_wait B1 = ("Subgroup")
putexcel_wait C1 = ("Measure")
putexcel_wait D1 = ("Timepoint")
putexcel_wait E1 = ("Obs")
putexcel_wait F1 = ("Mean1")
putexcel_wait G1 = ("SD1")
putexcel_wait H1 = ("Mean2")
putexcel_wait I1 = ("SD2")
putexcel_wait J1 = ("t-stat")
putexcel_wait K1 = ("df")
putexcel_wait L1 = ("p-unadj")
putexcel_wait M1 = ("MeanChange")
putexcel_wait N1 = ("SDChange")
putexcel_wait O1 = ("SRM")
putexcel_wait P1 = ("Corr")

local row = 2

* Rename variables so syntax is consistent, so they can be referred to in a loop consistently
rename W00_EQ5D_HSV W00_EQ5D
rename FU1_EQ5D_HSV FU1_EQ5D
rename FU2_EQ5D_HSV FU2_EQ5D
rename W00_ICECAP_A_WBV W00_ICECAP_A
rename FU1_ICECAP_A_WBV FU1_ICECAP_A
rename FU2_ICECAP_A_WBV FU2_ICECAP_A
rename W00_ASCOT_WBV W00_ASCOT
rename FU1_ASCOT_WBV FU1_ASCOT
rename FU2_ASCOT_WBV FU2_ASCOT

* Specify measures
local measures EQ5D MSIS_8D MSIS_8D_P ICECAP_A ASCOT

* BASELINE/PHASE 1 --> PHASE 2
* Specify groups
local promieqgroup ///
	MSWS_group_W00_FU1_6 ///
	MSWS_group_W00_FU1_8 ///
	HADS_D_group_W00_FU1 ///
	HADS_A_group_W00_FU1 ///
	FSS_group_W00_FU1 ///
	IEQ_Symptoms_1_W00_FU1 ///
	IEQ_Symptoms_2_W00_FU1 ///
	IEQ_Treatments_F_3_W00_FU1 ///
	FU1_IEQ_Treatments_4 ///
	FU1_IEQ_Treatments_5 ///
	IEQ_Treatments_6_W00_FU1 ///
	FU1_IEQ_Treatments_6a ///
	FU1_IEQ_Treatments_7 ///
	FU1_IEQ_Treatments_8 ///
	FU1_IEQ_Services_9a ///
	FU1_IEQ_Services_10a ///
	IEQ_Work_F_12_W00_FU1 ///
	FU1_IEQ_Work_13 ///
	FU1_IEQ_Work_14 ///
	FU1_IEQ_Work_15 ///
	FU1_IEQ_Work_16 ///
	IEQ_Diagnosis_17a_W00_FU1 ///
	IEQ_Relapses_F_18_W00_FU1
* Variables after this point were not included in data wrangling, would need amendments to make them into change variables

* Loop through groups
foreach group in `promieqgroup' {
	
	* Loop through the levels of that group (instead of bysort, so accounts for varying levels + saving results)
	levelsof `group', local(subgroups)
	foreach sub of local subgroups {
		
		* Loop through the PBMs/measures
		foreach measure in `measures'{
			
			* Save identifying details
			putexcel_wait A`row' = "`group'"
			putexcel_wait B`row' = `sub'
			putexcel_wait C`row' = "`measure'"
			putexcel_wait D`row' = "W00_FU1"
			
			* Save mean + SD at each timepoint, t-stat and p-value
			ttest W00_`measure' == FU1_`measure' if `group' == `sub'
			putexcel_wait E`row' = (r(N_1))
			putexcel_wait F`row' = (r(mu_1))
			putexcel_wait G`row' = (r(sd_1))
			putexcel_wait H`row' = (r(mu_2))
			putexcel_wait I`row' = (r(sd_2))
			putexcel_wait J`row' = (r(t))
			putexcel_wait K`row' = (r(df_t))
			putexcel_wait L`row' = (r(p))
			
			* Save mean change, SD of change and SRM
			sum(`measure'_W00_FU1) if `group' == `sub'
			putexcel_wait M`row' = (r(mean))
			putexcel_wait N`row' = (r(sd))
			putexcel_wait O`row' = (r(mean)/r(sd))
			
			* Save correlation (used for Cohen's D CI calculation)
			correlate W00_`measure' FU1_`measure' if `group' == `sub'
			putexcel_wait P`row' = (r(rho))

			local ++row
		}
	}
}

* PHASE 2 --> 3
* Specify groups
local promieqgroup ///
	MSWS_group_FU1_FU2_6 ///
	MSWS_group_FU1_FU2_8 ///
	HADS_D_group_FU1_FU2 ///
	HADS_A_group_FU1_FU2 ///
	FSS_group_FU1_FU2 ///
	IEQ_Symptoms_1_FU1_FU2 ///
	IEQ_Symptoms_2_FU1_FU2 ///
	IEQ_Treatments_F_3_FU1_FU2 ///
	FU2_IEQ_Treatments_4 ///
	FU2_IEQ_Treatments_5 ///
	IEQ_Treatments_6_FU1_FU2 ///
	FU2_IEQ_Treatments_6a ///
	FU2_IEQ_Treatments_7 ///
	FU2_IEQ_Treatments_8 ///
	FU2_IEQ_Services_9a ///
	FU2_IEQ_Services_10a ///
	IEQ_Work_F_12_FU1_FU2 ///
	FU2_IEQ_Work_13 ///
	FU2_IEQ_Work_14 ///
	FU2_IEQ_Work_15 ///
	FU2_IEQ_Work_16 ///
	IEQ_Diagnosis_17a_FU1_FU2 ///
	IEQ_Relapses_F_18_FU1_FU2
* Loop through groups
foreach group in `promieqgroup' {
	
	* Loop through the levels of that group (instead of bysort, so accounts for varying levels + saving results)
	levelsof `group', local(subgroups)
	foreach sub of local subgroups {
		
		* Loop through the PBMs/measures
		foreach measure in `measures'{
			
			* Save identifying details
			putexcel_wait A`row' = "`group'"
			putexcel_wait B`row' = `sub'
			putexcel_wait C`row' = "`measure'"
			putexcel_wait D`row' = "FU1_FU2"
			
			* Save mean + SD at each timepoint, t-stat and p-value
			ttest FU1_`measure' == FU2_`measure' if `group' == `sub'
			putexcel_wait E`row' = (r(N_1))
			putexcel_wait F`row' = (r(mu_1))
			putexcel_wait G`row' = (r(sd_1))
			putexcel_wait H`row' = (r(mu_2))
			putexcel_wait I`row' = (r(sd_2))
			putexcel_wait J`row' = (r(t))
			putexcel_wait K`row' = (r(df_t))
			putexcel_wait L`row' = (r(p))
			
			* Save mean change, SD of change and SRM
			sum(`measure'_FU1_FU2) if `group' == `sub'
			putexcel_wait M`row' = (r(mean))
			putexcel_wait N`row' = (r(sd))
			putexcel_wait O`row' = (r(mean)/r(sd))

			* Save correlation (used for Cohen's D CI calculation)
			correlate FU1_`measure' FU2_`measure' if `group' == `sub'
			putexcel_wait P`row' = (r(rho))
			
			local ++row
		}
	}
}

****************************************************************************************************
* Correlation between change in PBM and change in PROM
* Variables not all normally distributed so used Spearman's
****************************************************************************************************
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\FullResultsTable", sheet("Correlation") modify
putexcel_wait A1 = "PROM"
putexcel_wait B1 = "Measure"
putexcel_wait C1 = "Obs"
putexcel_wait D1 = "Spearman's Rho"
local row = 2
local promchange HADS_depression HADS_anxiety MSWS_tot_r FSS_tot
local measures EQ5D MSIS_8D MSIS_8D_P ICECAP_A ASCOT
foreach measure in `measures' {
	foreach change in `promchange' {
		
		putexcel_wait A`row' = "`change'_W00_FU1"
		putexcel_wait B`row' = "`measure'_W00_FU1"
		spearman `change'_W00_FU1 `measure'_W00_FU1
		putexcel_wait C`row' = (r(N))
		putexcel_wait D`row' = (r(rho))
		local ++row
		
		putexcel_wait A`row' = "`change'_FU1_FU2"
		putexcel_wait B`row' = "`measure'_FU1_FU2"
		spearman `change'_FU1_FU2 `measure'_FU1_FU2
		putexcel_wait C`row' = (r(N))
		putexcel_wait D`row' = (r(rho))
		local ++row
	}
}

********************************************************************************
* Correlations between the measures (not responsiveness, but related - validity)
********************************************************************************
pwcorr W00_EQ5D W00_MSIS_8D W00_MSIS_8D_P W00_ICECAP_A W00_ASCOT
pwcorr FU1_EQ5D FU1_MSIS_8D FU1_MSIS_8D_P FU1_ICECAP_A FU1_ASCOT
pwcorr FU2_EQ5D FU2_MSIS_8D FU2_MSIS_8D_P FU2_ICECAP_A FU2_ASCOT
