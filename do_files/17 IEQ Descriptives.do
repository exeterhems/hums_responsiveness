* SYNTAX FOR DESCRIPTIVES OF IEQ SAMPLE
* Amy Heather August 2021

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
* Tabulate - N (%) - for each IEQ question
****************************************************************************************************
* Local list of every IEQ question
local allIEQ ///
	IEQ_Symptoms_1 ///
	IEQ_Symptoms_2 ///
	IEQ_Treatments_F_3 ///
	IEQ_Treatments_4 ///
	IEQ_Treatments_5 ///
	IEQ_Treatments_5a ///
	IEQ_Treatments_6 ///
	IEQ_Treatments_6a ///
	IEQ_Treatments_7 ///
	IEQ_Treatments_8 ///
	IEQ_Treatments_8a ///
	IEQ_Services_9 ///
	IEQ_Services_9a ///
	IEQ_Services_10 ///
	IEQ_Services_10a ///
	IEQ_Work_F_12 ///
	IEQ_Work_13 ///
	IEQ_Work_13a ///
	IEQ_Work_14 ///
	IEQ_Work_14a ///
	IEQ_Work_15 ///
	IEQ_Work_15a ///
	IEQ_Work_16 ///
	IEQ_Work_16a ///
	IEQ_Diagnosis_F_17 ///
	IEQ_Diagnosis_17a ///
	IEQ_Relapses_F_18 ///
	IEQ_Relapses_19 ///
	IEQ_Relapses_20 ///
	IEQ_Relapses_21 ///
	IEQ_Relapses_22 ///
	IEQ_Relapses_23 ///
	IEQ_Relapses_F_24 ///
	IEQ_Relapses_25 ///
	IEQ_Relapses_26 ///
	IEQ_Relapses_27 ///
	IEQ_Relapses_28

* Local list of three timepoints
local timepoint W00 FU1 FU2

* Using xttab as it creates a matrix which is easy to export to Excel, unlike tab	
xtset UserId

* Set up excel with column labels
putexcel_wait set "HUMS Workstream 2 Phase 3\Results\IEQdescriptives", sheet("OriginalVar") replace
putexcel_wait A1 = ("Timepoint")
putexcel_wait B1 = ("Variable")
putexcel_wait C1 = ("Group")
putexcel_wait D1 = ("N")
putexcel_wait E1 = ("%")
putexcel_wait F1 = ("N")
putexcel_wait G1 = ("%")
putexcel_wait H1 = ("100%")
local row = 2

* Loop through each IEQ question at each timepoint, tabulate and save to Excel
foreach t in `timepoint' {
	foreach v in `allIEQ' {
		putexcel_wait A`row' = ("`t'")
		putexcel_wait B`row' = ("`v'")
		
		xttab `t'_`v'
		putexcel_wait C`row' = matrix(r(results))
		
		local dim = rowsof(r(results))
		local row = `row' + `dim'
	}
}

****************************************************************************************************
* Tabulate - N (%) - for the change variables generated from IEQ questions
****************************************************************************************************
* Local list of change variables
local changeIEQ ///
	IEQ_Symptoms_1 ///
	IEQ_Symptoms_2 ///
	IEQ_Treatments_F_3 ///
	IEQ_Treatments_6 ///
	IEQ_Work_F_12 ///
	IEQ_Diagnosis_17a ///
	IEQ_Relapses_F_18
	
* Local list of timepoints
local changetimepoint W00_FU1 FU1_FU2

* Loop through, tabulate and save to Excel
foreach t in `changetimepoint' {
	foreach v in `changeIEQ' {
		putexcel_wait A`row' = ("`t'")
		putexcel_wait B`row' = ("`v'")
		
		xttab `v'_`t'
		putexcel_wait C`row' = matrix(r(results))
		
		local dim = rowsof(r(results))
		local row = `row' + `dim'
	}
}

****************************************************************************************************
* Demographics for IEQ samples
****************************************************************************************************
* Create variables indicating if at least one IEQ question response for each timepoint
gen answerW00 = 0
foreach v in `allIEQ' {
	replace answerW00 = 1 if !mi(W00_`v')
}
gen answerFU1 = 0
foreach v in `allIEQ' {
	replace answerFU1 = 1 if !mi(FU1_`v')
}
gen answerFU2 = 0
foreach v in `allIEQ' {
	replace answerFU2 = 1 if !mi(FU2_`v')
}

* Local list of demographic variables
local demovar Gender MSTypeNow

* Loop through, tab, export to excel
foreach t in `timepoint' {
	foreach v in `demovar' {
		putexcel_wait A`row' = ("`t'")
		putexcel_wait B`row' = ("`v'")
		
		xttab `t'_`v' if answer`t' == 1
		putexcel_wait C`row' = matrix(r(results))
		
		local dim = rowsof(r(results))
		local row = `row' + `dim'
	}
}

* Mean age
sum W00_Age if answerW00==1
sum FU1_Age if answerFU1==1
sum FU2_Age if answerFU2==1
