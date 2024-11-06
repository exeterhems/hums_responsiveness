* SYNTAX FOR LONGITUDINAL ANALYSIS OF HSV AND WELLBEING DATA - Regression
* Amy Heather July 2021

version 15.1
cd "S:\ExeterWellbeingValue - Well being and Value - Exeter"

********************************************************************************
*** RESHAPE AND STANDARDISE THE DATA *******************************************
********************************************************************************

use "HUMS Workstream 2 Phase 3\PHASE 1 2 AND 3 DATA LongitudinalGroups.dta", replace

* Amend the IEQ Services variables to include no change from 9 + 10 to responses of 9a + 10a
* Else the variables are too small as only conditional responses
* And missing useful information of no change
* Needs to be one base case, so it's that services are same after change or no change
replace FU1_IEQ_Services_9a = 2 if FU1_IEQ_Services_9 == 2
replace FU2_IEQ_Services_9a = 2 if FU2_IEQ_Services_9 == 2
replace FU1_IEQ_Services_10a = 2 if FU1_IEQ_Services_10 == 2
replace FU2_IEQ_Services_10a = 2 if FU2_IEQ_Services_10 == 2
label define services_lab 1 "Better" 2 "No change or same after change" 3 "Worse"
label values FU1_IEQ_Services_9a services_lab
label values FU2_IEQ_Services_9a services_lab
label values FU1_IEQ_Services_10a services_lab
label values FU2_IEQ_Services_10a services_lab

* Amend IEQ Diagnosis 17a variable (else it can't be included as cancels out with relapses)
* As people with RRMS answered one, and people without answered the other
tab IEQ_Diagnosis_17a_W00_FU1 W00_IEQ_Diagnosis_F_17, missing
tab IEQ_Diagnosis_17a_W00_FU1 FU1_IEQ_Diagnosis_F_17, missing
* ^^^ Many say they don't have RRMS at P1 as well as at P2, but said transitioned from RRMS in that time
* To deal with this, set that they didn't respond yes to the RRMS to SPMS question
replace IEQ_Diagnosis_17a_W00_FU1 = 2 if (FU1_IEQ_Diagnosis_17a!=1 & W00_IEQ_Diagnosis_F_17==2 & FU1_IEQ_Diagnosis_F_17==2)
replace IEQ_Diagnosis_17a_FU1_FU2 = 2 if (FU2_IEQ_Diagnosis_17a!=1 & FU1_IEQ_Diagnosis_F_17==2 & FU2_IEQ_Diagnosis_F_17==2)
label define diagnosis_lab 1 "Change from RRMS to SPMS" 2 "No change (still RRMS, or still not RRMS)"
label values IEQ_Diagnosis_17a_W00_FU1 diagnosis_lab
label values IEQ_Diagnosis_17a_FU1_FU2 diagnosis_lab

* Amend IEQ Relapses variable (else it can't be included as cancels out with diagnosis)
tab IEQ_Relapses_F_18_W00_FU1
replace IEQ_Relapses_F_18_W00_FU1 = 4 if (W00_IEQ_Diagnosis_F_17==2 & FU1_IEQ_Diagnosis_F_17==2)
replace IEQ_Relapses_F_18_FU1_FU2 = 4 if (FU1_IEQ_Diagnosis_F_17==2 & FU2_IEQ_Diagnosis_F_17==2)
label define relapses_lab 1 "P1 yes; P2 no" 2 "P1 no; P2 yes" 3 "P1 yes; P2 yes" ///
	4 "No relapses - RRMS P1+P2 no relapse OR not RRMS at P1+P2"
label values IEQ_Relapses_F_18_W00_FU1 relapses_lab
label values IEQ_Relapses_F_18_FU1_FU2 relapses_lab

* Rename variables as some would otherwise cause conflict (e.g. EQ5D would also cover EQ5D_mapB)
local renamelist MSIS_8D_W00_FU1 MSIS_8D_FU1_FU2 ///
	EQ5D_mapB_W00_FU1 EQ5D_mapB_FU1_FU2 EQ5D_mapF_W00_FU1 EQ5D_mapF_FU1_FU2 ///
	SF6D_mapB_W00_FU1 SF6D_mapB_FU1_FU2 SF6D_mapF_W00_FU1 SF6D_mapF_FU1_FU2
foreach v of varlist `renamelist' {
	local name: subinstr local v "_" ""
	rename `v' `name'
}
rename MSWS_group_W00_FU1_6 MSWS_group6_W00_FU1
rename MSWS_group_FU1_FU2_6 MSWS_group6_FU1_FU2
rename MSWS_group_W00_FU1_8 MSWS_group8_W00_FU1
rename MSWS_group_FU1_FU2_8 MSWS_group8_FU1_FU2
rename FU1_IEQ_Treatments_4 IEQ_Treatments_4_W00_FU1
rename FU2_IEQ_Treatments_4 IEQ_Treatments_4_FU1_FU2
rename FU1_IEQ_Treatments_5 IEQ_Treatments_5_W00_FU1
rename FU2_IEQ_Treatments_5 IEQ_Treatments_5_FU1_FU2
rename FU1_IEQ_Treatments_7 IEQ_Treatments_7_W00_FU1
rename FU2_IEQ_Treatments_7 IEQ_Treatments_7_FU1_FU2
rename FU1_IEQ_Treatments_8 IEQ_Treatments_8_W00_FU1
rename FU2_IEQ_Treatments_8 IEQ_Treatments_8_FU1_FU2
rename FU1_IEQ_Services_9a IEQ_Services_9a_W00_FU1
rename FU2_IEQ_Services_9a IEQ_Services_9a_FU1_FU2
rename FU1_IEQ_Services_10a IEQ_Services_10a_W00_FU1
rename FU2_IEQ_Services_10a IEQ_Services_10a_FU1_FU2
rename FU1_IEQ_Work_13 IEQ_Work_13_W00_FU1
rename FU2_IEQ_Work_13 IEQ_Work_13_FU1_FU2
rename FU1_IEQ_Work_14 IEQ_Work_14_W00_FU1
rename FU2_IEQ_Work_14 IEQ_Work_14_FU1_FU2
rename FU1_IEQ_Work_15 IEQ_Work_15_W00_FU1
rename FU2_IEQ_Work_15 IEQ_Work_15_FU1_FU2
rename FU1_IEQ_Work_16 IEQ_Work_16_W00_FU1
rename FU2_IEQ_Work_16 IEQ_Work_16_FU1_FU2

* Reshape from wide to long
local pbmpromlist MSIS8D MSIS_8D_P EQ5D EQ5DmapB EQ5DmapF SF6DmapB SF6DmapF ///
	ICECAP_A ASCOT HADS_depression HADS_anxiety MSWS_tot_r FSS_tot
local catpromlist MSWS_group6 MSWS_group8 HADS_D_group HADS_A_group FSS_group
local ieqlist IEQ_Symptoms_1 IEQ_Symptoms_2 IEQ_Treatments_F_3 ///
	IEQ_Treatments_4 IEQ_Treatments_5 IEQ_Treatments_6 IEQ_Treatments_7 ///
	IEQ_Treatments_8 IEQ_Services_9a IEQ_Services_10a IEQ_Work_F_12 IEQ_Work_13 ///
	IEQ_Work_14 IEQ_Work_15 IEQ_Work_16 IEQ_Diagnosis_17a IEQ_Relapses_F_18
reshape long `pbmpromlist' `catpromlist' `ieqlist', i(UserId) j(Timepoint, string)

* Generate numeric version of Timepoint
gen TimepointN = .
replace TimepointN = 1 if Timepoint == "_W00_FU1"
replace TimepointN = 2 if Timepoint == "_FU1_FU2"
label define TimepointN_lab 1 "Phase 1 to 2" 2 "Phase 2 to 3"
label values TimepointN TimepointN_lab

* Standardise the PBMs and PROMS
foreach v of varlist `pbmpromlist' {
	egen std`v' = std(`v')
}

* Recode IEQ questions so no change is base case (0), then change are 1 and 2
recode IEQ_Symptoms_2 (3/4=0) (1=1) (2=2), gen(IEQ_Symptoms_2_Recode)
label var IEQ_Symptoms_2_Recode "Currently experiencing complications or side effects"
recode IEQ_Treatments_F_3 (3/4=0) (1=1) (2=2), gen(IEQ_Treatments_F_3_Recode)
label var IEQ_Treatments_F_3_Recode "Any MS treatments in the last 6 months"
recode IEQ_Treatments_6 (3/4=0) (1=1) (2=2), gen(IEQ_Treatments_6_Recode)
label var IEQ_Treatments_6_Recode "Any DMT in last 6 months"
recode IEQ_Work_F_12 (3/4=0) (1=1) (2=2), gen(IEQ_Work_F_12_Recode)
label var IEQ_Work_F_12_Recode "Any paid work"
recode IEQ_Relapses_F_18 (3/4=0) (1=1) (2=2), gen(IEQ_Relapses_F_18_Recode)
label var IEQ_Relapses_F_18_Recode "Any MS relapses"
label define IEQ_Recode_012_Lab 0 "No change" ///
	1 "Pt1 yes; Pt2 no" ///
	2 "Pt1 no; Pt2 yes"
label values IEQ_Symptoms_2_Recode IEQ_Recode_012_Lab
label values IEQ_Treatments_F_3_Recode IEQ_Recode_012_Lab
label values IEQ_Treatments_6_Recode IEQ_Recode_012_Lab
label values IEQ_Work_F_12_Recode IEQ_Recode_012_Lab
label values IEQ_Relapses_F_18_Recode IEQ_Recode_012_Lab

recode IEQ_Treatments_4 (2=0) (1=1), gen(IEQ_Treatments_4_Recode)
label var IEQ_Treatments_4_Recode "Started a drug for MS treatment"
recode IEQ_Treatments_5 (2=0) (1=1), gen(IEQ_Treatments_5_Recode)
label var IEQ_Treatments_5_Recode "Stopped a drug treatment for MS symptoms"
recode IEQ_Treatments_7 (2=0) (1=1), gen(IEQ_Treatments_7_Recode)
label var IEQ_Treatments_7_Recode "Started non-drug treatment for MS in last 6 months"
recode IEQ_Treatments_8 (2=0) (1=1), gen(IEQ_Treatments_8_Recode)
label var IEQ_Treatments_8_Recode "Stopped non-drug treatment for MS in the last 6 months"
recode IEQ_Work_13 (2=0) (1=1), gen(IEQ_Work_13_Recode)
label var IEQ_Work_13_Recode "Left job"
recode IEQ_Work_14 (2=0) (1=1), gen(IEQ_Work_14_Recode)
label var IEQ_Work_14_Recode "Changed job"
recode IEQ_Work_15 (2=0) (1=1), gen(IEQ_Work_15_Recode)
label var IEQ_Work_15_Recode "Reduced working hours"
recode IEQ_Work_16 (2=0) (1=1), gen(IEQ_Work_16_Recode)
label var IEQ_Work_16_Recode "In last 6 months, gone back to work after been off due to MS"
recode IEQ_Diagnosis_17a (2=0) (1=1), gen(IEQ_Diagnosis_17a_Recode)
label var IEQ_Diagnosis_17a "Change in diagnosis from RRMS to SPMS"
label define IEQ_Recode_01_Lab 0 "No change (Pt2 no)" 1 "Change (Pt2 yes)"
label values IEQ_Treatments_4_Recode IEQ_Recode_01_Lab
label values IEQ_Treatments_5_Recode IEQ_Recode_01_Lab
label values IEQ_Treatments_7_Recode IEQ_Recode_01_Lab
label values IEQ_Treatments_8_Recode IEQ_Recode_01_Lab
label values IEQ_Work_13_Recode IEQ_Recode_01_Lab
label values IEQ_Work_14_Recode IEQ_Recode_01_Lab
label values IEQ_Work_15_Recode IEQ_Recode_01_Lab
label values IEQ_Work_16_Recode IEQ_Recode_01_Lab
label values IEQ_Diagnosis_17a_Recode IEQ_Recode_01_Lab

recode IEQ_Symptoms_1 (4=0) (1=1) (2=2) (3=3), gen(IEQ_Symptoms_1_Recode)
label var IEQ_Symptoms_1_Recode "Currently experiencing new symptoms"
label define IEQ_Recode_Symp1_Lab 0 "No change (Pt1 no; Pt2 no)" ///
	1 "Pt1 yes; Pt2 no" ///
	2 "Pt1 no; Pt2 yes" ///
	3 "Pt 1 yes; Pt2 yes"
label values IEQ_Symptoms_1_Recode IEQ_Recode_Symp1_Lab

recode IEQ_Services_9a (2=0) (1=1) (3=2), gen(IEQ_Services_9a_Recode)
label var IEQ_Services_9a_Recode "Change in NHS or social care services"
recode IEQ_Services_10a (2=0) (1=1) (3=2), gen(IEQ_Services_10a_Recode)
label var IEQ_Services_10a_Recode "Change in services or support you pay yourself"
label define IEQ_Recode_9a10a_Lab 0 "No change in services or same after change" 1 "Better services/support" 2 "Worse services/support"
label values IEQ_Services_9a_Recode IEQ_Recode_9a10a_Lab
label values IEQ_Services_10a_Recode IEQ_Recode_9a10a_Lab

tab IEQ_Symptoms_1 IEQ_Symptoms_1_Recode, missing
tab IEQ_Symptoms_2 IEQ_Symptoms_2_Recode, missing
tab IEQ_Treatments_F_3 IEQ_Treatments_F_3_Recode, missing
tab IEQ_Treatments_4 IEQ_Treatments_4_Recode, missing
tab IEQ_Treatments_5 IEQ_Treatments_5_Recode, missing
tab IEQ_Treatments_6 IEQ_Treatments_6_Recode, missing
tab IEQ_Treatments_7 IEQ_Treatments_7_Recode, missing
tab IEQ_Treatments_8 IEQ_Treatments_8_Recode, missing
tab IEQ_Services_9a IEQ_Services_9a_Recode, missing
tab IEQ_Services_10a IEQ_Services_10a_Recode, missing
tab IEQ_Work_F_12 IEQ_Work_F_12_Recode, missing
tab IEQ_Work_13 IEQ_Work_13_Recode, missing
tab IEQ_Work_14 IEQ_Work_14_Recode, missing
tab IEQ_Work_15 IEQ_Work_15_Recode, missing
tab IEQ_Work_16 IEQ_Work_16_Recode, missing
tab IEQ_Diagnosis_17a IEQ_Diagnosis_17a_Recode, missing
tab IEQ_Relapses_F_18 IEQ_Relapses_F_18_Recode, missing

* Create filter variable for PBMs
local timepoints _W00_FU1 _FU1_FU2
gen All_data_PBMs = 0
foreach time in `timepoints' {
	replace All_data_PBMs = 1 if (Timepoint=="`time'" & ///
		stdEQ5D!=. & stdMSIS_8D!=. & stdICECAP_A!=. & stdASCOT!=. & ///
		stdHADS_depression!=. & stdHADS_anxiety!=. & stdMSWS_tot_r!=. & stdFSS_tot!=.)
}

save "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace

********************************************************************************
*** REGRESSION WITH CONTINUOUS VARIABLES - PBMs ********************************
********************************************************************************

use "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace
keep if All_data_PBMs == 1

* Set data as panel data (note; it is strongly balanced, which is ideal)
xtset UserId TimepointN

* Create lists of relevant variables
local pbmlist stdEQ5D stdMSIS8D stdMSIS_8D_P stdICECAP_A stdASCOT
local promlist stdHADS_depression stdHADS_anxiety stdMSWS_tot_r stdFSS_tot

* Hausman test - none are significant, suggesting that random effects should be used
* (F test also lacks significance - see bottom of xtreg,fe outcome table)
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
}
* Breusch-Pagan Lagrange multiplier (LM) - none are significant, so fail to reject null
* Conclude that RE is not appropriate - that is, no evidence of significant differences
* across timepoints, so can run a simple pooled OLS regression
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist', re
	qui xttest0
	display r(p)
}

* Pooled OLS Regression with clustered standard errors
* Cluster as observations from same panel are assumed to be more similar than those from different
* panels - otherwise the model is treating the observations as independent (which they are not)
* (see pg 13 to 14 of regress Stata manual for further details)
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMProm", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMProm", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}

* Assumptions of pooled OLS regression
foreach pbm in `pbmlist' {
	regress `pbm' `promlist'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' `promlist'
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid`pbm', resid
	hist resid`pbm'
	kdensity resid`pbm', normal
	pnorm resid`pbm'
	qnorm resid`pbm'
	swilk resid`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid`pbm' stdHADS_depression
	scatter resid`pbm' stdHADS_anxiety
	scatter resid`pbm' stdMSWS_tot_r
	scatter resid`pbm' stdFSS_tot
	acprplot stdHADS_depression, lowess lsopts(bwidth(1))
	acprplot stdHADS_anxiety, lowess lsopts(bwidth(1))
	acprplot stdMSWS_tot_r, lowess lsopts(bwidth(1))
	acprplot stdFSS_tot, lowess lsopts(bwidth(1))

	* Model specification error
	linktest
	ovtest
}
* From looking in detail at EQ5D and glancing through others to check they all look similar...
* Failed assumption:
* --> Normality of residuals
* Passed assumption:
* --> No outliers
* --> Homoscedasticity of Residuals
* --> No multicolinearity
* --> Relationship between response variables and predictors is linear

********************************************************************************
*** REGRESSION WITH CATEGORICAL VARIABLES - PBMs *******************************
********************************************************************************

use "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace
keep if All_data_PBMs==1

* Set data as panel data (note; it is strongly balanced, which is ideal)
xtset UserId TimepointN

* Find number of people in each group
xttab MSWS_group6
xttab MSWS_group8
xttab HADS_D_group
xttab HADS_A_group
xttab FSS_group

* Create lists of relevant variables
local pbmlist stdEQ5D stdMSIS8D stdMSIS_8D_P stdICECAP_A stdASCOT
local promlist6 i.MSWS_group6 i.HADS_D_group i.HADS_A_group i.FSS_group
local promlist8 i.MSWS_group8 i.HADS_D_group i.HADS_A_group i.FSS_group

* Hausman test - none are significant, suggesting that random effects should be used
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist6', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist6', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
	
	qui xtreg `pbm' `promlist8', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist8', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
}
* Breusch-Pagan Lagrange multiplier (LM) - none are significant, so fail to reject null
* Conclude that RE is not appropriate - that is, no evidence of significant differences
* across countries, so can run a simple pooled OLS regression
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist6', re
	qui xttest0
	display r(p)
	
	qui xtreg `pbm' `promlist8', re
	qui xttest0
	display r(p)
}

* Pooled OLS Regression with clustered standard errors
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMPromCatMSWS6", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, PBMs, categorical PROMs"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist6', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMPromCatMSWS6", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMPromCatMSWS8", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, PBMs, categorical PROMs"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist8', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsPBMPromCatMSWS8", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}

* Assumptions of pooled OLS regression (for regression with MSWS group 6...)
foreach pbm in `pbmlist' {
	regress `pbm' `promlist6'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' MSWS_group6 HADS_D_group HADS_A_group FSS_group
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid`pbm', resid
	hist resid`pbm'
	kdensity resid`pbm', normal
	pnorm resid`pbm'
	qnorm resid`pbm'
	swilk resid`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist6'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid`pbm' HADS_D_group
	scatter resid`pbm' HADS_A_group
	scatter resid`pbm' FSS_group
	scatter resid`pbm' MSWS_group6

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

* Assumptions of pooled OLS regression (for regression with MSWS group 8...)
foreach pbm in `pbmlist' {
	regress `pbm' `promlist8'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' MSWS_group8 HADS_D_group HADS_A_group FSS_group
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid2`pbm', resid
	hist resid2`pbm'
	kdensity resid2`pbm', normal
	pnorm resid2`pbm'
	qnorm resid2`pbm'
	swilk resid2`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist8'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid2`pbm' HADS_D_group
	scatter resid2`pbm' HADS_A_group
	scatter resid2`pbm' FSS_group
	scatter resid2`pbm' MSWS_group8

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

********************************************************************************
*** REGRESSION WITH CONTINUOUS VARIABLES - Mapping Algorithms ******************
********************************************************************************

use "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace
keep if All_data_mapping==1

* Set data as panel data (note; it is strongly balanced, which is ideal)
xtset UserId TimepointN

* Create lists of relevant variables
local pbmlist stdEQ5D stdMSIS8D stdEQ5DmapB stdEQ5DmapF stdSF6DmapB stdSF6DmapF
local promlist stdHADS_depression stdHADS_anxiety stdMSWS_tot_r stdFSS_tot

* Hausman test - none are significant, suggesting that random effects should be used
/*
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
}
* Breusch-Pagan Lagrange multiplier (LM) - none are significant, so fail to reject null
* Conclude that RE is not appropriate - that is, no evidence of significant differences
* across countries, so can run a simple pooled OLS regression
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist', re
	qui xttest0
	display r(p)
}
*/

* Pooled OLS Regression with clustered standard errors
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMap", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, mapping"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMap", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}

* Assumptions of pooled OLS regression
foreach pbm in `pbmlist' {
	regress `pbm' `promlist'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' `promlist'
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid`pbm', resid
	hist resid`pbm'
	kdensity resid`pbm', normal
	pnorm resid`pbm'
	qnorm resid`pbm'
	swilk resid`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid`pbm' stdHADS_depression
	scatter resid`pbm' stdHADS_anxiety
	scatter resid`pbm' stdMSWS_tot_r
	scatter resid`pbm' stdFSS_tot
	acprplot stdHADS_depression, lowess lsopts(bwidth(1))
	acprplot stdHADS_anxiety, lowess lsopts(bwidth(1))
	acprplot stdMSWS_tot_r, lowess lsopts(bwidth(1))
	acprplot stdFSS_tot, lowess lsopts(bwidth(1))

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

********************************************************************************
*** REGRESSION WITH CATEGORICAL VARIABLES - Mapping Algorithms *****************
********************************************************************************

use "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace
keep if All_data_mapping==1

* Set data as panel data (note; it is strongly balanced, which is ideal)
xtset UserId TimepointN

* Create lists of relevant variables
local pbmlist stdEQ5D stdMSIS8D stdEQ5DmapB stdEQ5DmapF stdSF6DmapB stdSF6DmapF
local promlist6 i.MSWS_group6 i.HADS_D_group i.HADS_A_group i.FSS_group
local promlist8 i.MSWS_group8 i.HADS_D_group i.HADS_A_group i.FSS_group

/*
* Hausman test - none are significant, suggesting that random effects should be used
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist6', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist6', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
	
	qui xtreg `pbm' `promlist8', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `promlist8', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
}
* Breusch-Pagan Lagrange multiplier (LM) - none are significant, so fail to reject null
* Conclude that RE is not appropriate - that is, no evidence of significant differences
* across countries, so can run a simple pooled OLS regression
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `promlist6', re
	qui xttest0
	display r(p)
	
	qui xtreg `pbm' `promlist8', re
	qui xttest0
	display r(p)
}
*/

* Pooled OLS Regression with clustered standard errors
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMapPromCatMSWS6", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, mapping, categorical PROMs"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist6', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMapPromCatMSWS6", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMapPromCatMSWS8", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, mapping, categorical PROMs"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `promlist8', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsMapPromCatMSWS8", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}

* Assumptions of pooled OLS regression (for regression with MSWS group 6...)
foreach pbm in `pbmlist' {
	regress `pbm' `promlist6'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' MSWS_group6 HADS_D_group HADS_A_group FSS_group
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid`pbm', resid
	hist resid`pbm'
	kdensity resid`pbm', normal
	pnorm resid`pbm'
	qnorm resid`pbm'
	swilk resid`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist6'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid`pbm' HADS_D_group
	scatter resid`pbm' HADS_A_group
	scatter resid`pbm' FSS_group
	scatter resid`pbm' MSWS_group6

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

* Assumptions of pooled OLS regression (for regression with MSWS group 8...)
foreach pbm in `pbmlist' {
	regress `pbm' `promlist8'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' MSWS_group8 HADS_D_group HADS_A_group FSS_group
	
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid2`pbm', resid
	hist resid2`pbm'
	kdensity resid2`pbm', normal
	pnorm resid2`pbm'
	qnorm resid2`pbm'
	swilk resid2`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `promlist8'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* ACPRplot - if close to ordinary regresion line and uniform
	scatter resid2`pbm' HADS_D_group
	scatter resid2`pbm' HADS_A_group
	scatter resid2`pbm' FSS_group
	scatter resid2`pbm' MSWS_group8

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

********************************************************************************
*** REGRESSION - IEQ ***********************************************************
********************************************************************************

use "HUMS Workstream 2 Phase 3\Phase123Wide.dta", replace

local timepoints _W00_FU1 _FU1_FU2
gen All_data_IEQ = 0
foreach time in `timepoints' {
	replace All_data_IEQ = 1 if (Timepoint=="`time'" & ///
		stdEQ5D!=. & stdMSIS_8D!=. & stdICECAP_A!=. & stdASCOT!=. & ///
		IEQ_Symptoms_1!=. & IEQ_Symptoms_2!=. & IEQ_Treatments_F_3!=. & ///
		IEQ_Services_9a!=. & IEQ_Services_10a!=. & IEQ_Work_F_12!=. & ///
		IEQ_Diagnosis_17a!=. & IEQ_Relapses_F_18!=.)
}
keep if All_data_IEQ == 1

* Set data as panel data (note; it is strongly balanced, which is ideal)
xtset UserId TimepointN

* Find number of people in each group
xttab IEQ_Symptoms_1_Recode
xttab IEQ_Symptoms_2_Recode
xttab IEQ_Treatments_F_3_Recode
xttab IEQ_Services_9a_Recode
xttab IEQ_Services_10a_Recode
xttab IEQ_Work_F_12_Recode
xttab IEQ_Diagnosis_17a_Recode
xttab IEQ_Relapses_F_18_Recode

* Create lists of relevant variables
local pbmlist stdEQ5D stdMSIS8D stdMSIS_8D_P stdICECAP_A stdASCOT
local ieqlist i.IEQ_Symptoms_1_Recode i.IEQ_Symptoms_2_Recode ///
	i.IEQ_Treatments_F_3_Recode i.IEQ_Services_9a_Recode i.IEQ_Services_10a_Recode ///
	i.IEQ_Work_F_12_Recode i.IEQ_Diagnosis_17a_Recode i.IEQ_Relapses_F_18_Recode
	
* Hausman test - four are not significant, suggesting that random effects should be used
* One is significant, suggesting fixed effects
/*
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `ieqlist', fe
	qui estimates store `pbm'fe
	qui xtreg `pbm' `ieqlist', re
	qui estimates store `pbm're
	qui hausman `pbm'fe `pbm're
	display r(p)
}
* Breusch-Pagan Lagrange multiplier (LM) - none are significant, so fail to reject null
* Conclude that RE is not appropriate - that is, no evidence of significant differences
* across countries, so can run a simple pooled OLS regression
foreach pbm of varlist `pbmlist' {
	qui xtreg `pbm' `ieqlist', re
	qui xttest0
	display r(p)
}
*/

* Pooled OLS Regression with clustered standard errors
putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsIEQ", sheet("Title") replace
putexcel A1 = "Pooled OLS regression with clustered standard errors, phase 1 to 3, IEQ"
foreach pbm of varlist `pbmlist' {
	regress `pbm' `ieqlist', vce(cluster UserId)
	matrix result = r(table)'
	putexcel set "HUMS Workstream 2 Phase 3\Results\Phase123RegressionResultsIEQ", sheet("`pbm'") modify
	putexcel A1=matrix(result), names
}

* Assumptions of pooled OLS regression
foreach pbm in `pbmlist' {
	regress `pbm' `ieqlist'
	
	* Assumption: Not Outliers
	* It would be concerning if we saw a data point far from the rest of the data points in these graphs
	graph matrix `pbm' IEQ_Symptoms_1_Recode IEQ_Symptoms_2_Recode IEQ_Treatments_4_Recode ///
		IEQ_Treatments_5_Recode IEQ_Treatments_6_Recode IEQ_Treatments_7_Recode IEQ_Treatments_8_Recode ///
		IEQ_Work_F_12_Recode IEQ_Work_15_Recode IEQ_Work_16_Recode IEQ_Relapses_F_18_Recode
		
	* Assumption: Normality of residuals
	* Observe whether they appear normal in hist & kdensity
	* And if non-normality is indicated in pnorm and qnorm (deviation from that normal line)
	* And if swilk p<0.05 it means that we can reject that r is normally distributed
	predict resid`pbm', resid
	hist resid`pbm'
	kdensity resid`pbm', normal
	pnorm resid`pbm'
	qnorm resid`pbm'
	swilk resid`pbm'
	
	* Assumption: Homoscedasticity of Residuals - homogeneity of variance of residuals
	* Low p-value means we reject the hypothesis and accept that variance is NOT homogeneous
	* However, it is common practice to combine tests with diagnostic plots to make judgement of severity
	* Since the tests are very sensitive to model assumptions like normality
	rvfplot, yline(0)
	estat imtest
	estat hettest
	
	* Assumption: No multicolinearity
	* VIF of 10+ indicates multicolinearity
	_rmdcoll `pbm' `ieqlist'
	vif

	* Assumption: relationship between response variables and predictors is linear
	* (Otherwise will try to fit a straight line to data that does not follow a straight line)
	* Scatter - can you see any non-normal patterns? 
	* Would do scatter resid`pbm' IEQvar
	* HOWEVER, they are all categorical, so you would not observe anything

	* Model specification error
	linktest
	ovtest
}
* Assumption status similar to PBM continuous PROM regression

********************************************************************************
*** Original code by Liz *******************************************************
********************************************************************************
/*
***RESHAPE FROM WIDE TO LONG
gen Change1 = 1
gen Change2 = 2
reshape long Change, i(UserId) j(Timepoint)
label define timepoint 1 "TP1 to TP2" 2 "TP2 to TP3"
label values Timepoint timepoint

***CREATE CHANGE SCORES FOR PBMs, MAPPING ALGORITHMS AND WBMs***

***CREATE NEW VARIABLES FOR EACH "CHANGE" VARIABLES FOR PBMs AND PROMs, SUCH THAT
******NEW VARIABLE = OLD VAR (TP1-TP2) IF Timepoint = 1
******NEW VARIABLE = OLD VAR (TP1-TP2) IF Timepoint = 2

*Calculate difference (ie change score) in MSIS-8D HSVs
gen MSIS_8D_change = .
replace MSIS_8D_change = MSIS_8D_W00_FU1 if Timepoint==1
replace MSIS_8D_change = MSIS_8D_FU1_FU2 if Timepoint==2
label var MSIS_8D_change "MSIS-8D change score"
sum MSIS_8D_change if  All_data_PBMs==1
sum MSIS_8D_change if  All_data_mapping==1


*Calculate difference (ie change score) in MSIS-8D-P HSVs
gen MSIS_8D_P_change = .
replace MSIS_8D_P_change = MSIS_8D_P_W00_FU1 if Timepoint==1
replace MSIS_8D_P_change = MSIS_8D_P_FU1_FU2 if Timepoint==2
label var MSIS_8D_P_change "MSIS-8D-P change score"
sum MSIS_8D_P_change if  All_data_PBMs==1
sum MSIS_8D_P_change if  All_data_mapping==1

*Calculate difference (ie change score) in EQ-5D HSVs
gen EQ5D_change = .
replace EQ5D_change = EQ5D_W00_FU1 if Timepoint==1
replace EQ5D_change = EQ5D_FU1_FU2 if Timepoint==2
label var EQ5D_change "EQ-5D change score"
sum EQ5D_change if  All_data_PBMs==1
sum EQ5D_change if  All_data_mapping==1

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model B)
gen EQ5D_mapB_change = .
replace EQ5D_mapB_change = EQ5D_mapB_W00_FU1 if Timepoint==1
replace EQ5D_mapB_change = EQ5D_mapB_FU1_FU2 if Timepoint==2
label var EQ5D_mapB_change "EQ-5D mapping algorithm B change score"
sum EQ5D_mapB_change if  All_data_mapping==1

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model F)
gen EQ5D_mapF_change = .
replace EQ5D_mapF_change = EQ5D_mapF_W00_FU1 if Timepoint==1
replace EQ5D_mapF_change = EQ5D_mapF_FU1_FU2 if Timepoint==2
label var EQ5D_mapF_change "EQ-5D mapping algorithm F change score"
sum EQ5D_mapF_change if  All_data_mapping==1

*Calculate difference (ie change score) in mapped SF-6D HSVs (model B)
gen SF6D_mapB_change = .
replace SF6D_mapB_change = SF6D_mapB_W00_FU1 if Timepoint==1
replace SF6D_mapB_change = SF6D_mapB_FU1_FU2 if Timepoint==2
label var SF6D_mapB_change "SF-6D mapping algorithm B change score"
sum SF6D_mapB_change if  All_data_mapping==1

*Calculate difference (ie change score) in mapped SF-6D HSVs (model F)
gen SF6D_mapF_change = .
replace SF6D_mapF_change = SF6D_mapF_W00_FU1 if Timepoint==1
replace SF6D_mapF_change = SF6D_mapF_FU1_FU2 if Timepoint==2
label var SF6D_mapF_change "SF-6D mapping algorithm F change score"
sum SF6D_mapF_change if  All_data_mapping==1

*Calculate difference (ie change score) in ICECAP-A WBVs
gen ICECAP_change = .
replace ICECAP_change = ICECAP_A_W00_FU1 if Timepoint==1
replace ICECAP_change = ICECAP_A_FU1_FU2 if Timepoint==2
label var ICECAP_change "ICECAP-A change score"
sum ICECAP_change if  All_data_PBMs==1

*Calculate difference (ie change score) in ASCOT WBVs
gen ASCOT_change = .
replace ASCOT_change = ASCOT_W00_FU1 if Timepoint==1
replace ASCOT_change = ASCOT_FU1_FU2 if Timepoint==2
label var ASCOT_change "ASCOT change score"
sum ASCOT_change if  All_data_PBMs==1

***CREATE CHANGE SCORES FOR PROMs***

*Calculate difference (ie change score) in HADS depression scores
gen HADS_D_change = .
replace HADS_D_change = HADS_depression_W00_FU1 if Timepoint==1
replace HADS_D_change = HADS_depression_FU1_FU2 if Timepoint==2
label var HADS_D_change "HADS depression change score"
sum HADS_D_change if  All_data_PBMs==1
sum HADS_D_change if  All_data_mapping==1

*Calculate difference (ie change score) in HADS anxiety scores
gen HADS_A_change = .
replace HADS_A_change = HADS_anxiety_W00_FU1 if Timepoint==1
replace HADS_A_change = HADS_anxiety_FU1_FU2 if Timepoint==2
label var HADS_A_change "HADS anxiety change score"
sum HADS_A_change if  All_data_PBMs==1
sum HADS_A_change if  All_data_mapping==1

*Calculate difference (ie change score) in MSWS-12 transformed scores
gen MSWS_12_change = .
replace MSWS_12_change = MSWS_tot_r_W00_FU1 if Timepoint==1
replace MSWS_12_change = MSWS_tot_r_FU1_FU2 if Timepoint==2
label var MSWS_12_change "MSWS-12 change score"
sum MSWS_12_change if  All_data_PBMs==1
sum MSWS_12_change if  All_data_mapping==1

*Calculate difference (ie change score) in FSS total scores
gen FSS_change = .
replace FSS_change = FSS_tot_W00_FU1 if Timepoint==1
replace FSS_change = FSS_tot_FU1_FU2 if Timepoint==2
label var FSS_change "FSS change score"
sum FSS_change if  All_data_PBMs==1
sum FSS_change if All_data_mapping==1


***Create standardised version of the change score variables for the PBM/wellbeing analysis
*egen z_MSIS_8D_change = std(MSIS_8D_change) if All_data_PBMs==1
*sum z_MSIS_8D_change if All_data_PBMs==1 
*egen z_MSIS_8D_P_change = std(MSIS_8D_P_change) if All_data_PBMs==1
*sum z_MSIS_8D_P_change if All_data_PBMs==1
*egen z_EQ5D_change = std(EQ5D_change) if All_data_PBMs==1
*sum z_EQ5D_change if All_data_PBMs==1
*egen z_ICECAP_change = std(ICECAP_change) if All_data_PBMs==1
*sum z_ICECAP_change if All_data_PBMs==1
*egen z_ASCOT_change = std(ASCOT_change) if All_data_PBMs==1
*sum z_ASCOT_change if All_data_PBMs==1

*egen z_HADS_D_change = std(HADS_D_change) if All_data_PBMs==1
*sum z_HADS_D_change if All_data_PBMs==1 
*egen z_HADS_A_change = std(HADS_A_change) if All_data_PBMs==1
*sum z_HADS_A_change if All_data_PBMs==1
*egen z_MSWS_12_change = std(MSWS_12_change) if All_data_PBMs==1
*sum z_MSWS_12_change if All_data_PBMs==1
*egen z_FSS_change = std(FSS_change) if All_data_PBMs==1
*sum z_FSS_change if All_data_PBMs==1


***Create standardised version of the change score variables for the mapping algorithms analysis
*egen z2_EQ5D_mapB_change = std(EQ5D_mapB_change) if All_data_mapping==1
*sum z2_EQ5D_mapB_change if All_data_mapping==1
*egen z2_EQ5D_mapF_change = std(EQ5D_mapF_change) if All_data_mapping==1
*sum z2_EQ5D_mapF_change if All_data_mapping==1
*egen z2_SF6D_mapB_change = std(SF6D_mapB_change) if All_data_mapping==1
*sum z2_SF6D_mapB_change if All_data_mapping==1
*egen z2_SF6D_mapF_change = std(SF6D_mapF_change) if All_data_mapping==1
*sum z2_SF6D_mapF_change if All_data_mapping==1

*egen z2_MSIS_8D_change = std(MSIS_8D_change) if All_data_mapping==1
*sum z2_MSIS_8D_change if All_data_mapping==1 
*egen z2_EQ5D_change = std(EQ5D_change) if All_data_mapping==1
*sum z2_EQ5D_change if All_data_mapping==1

*egen z2_HADS_D_change = std(HADS_D_change) if All_data_mapping==1
*sum z2_HADS_D_change if All_data_mapping==1 
*egen z2_HADS_A_change = std(HADS_A_change) if All_data_mapping==1
*sum z2_HADS_A_change if All_data_mapping==1
*egen z2_MSWS_12_change = std(MSWS_12_change) if All_data_mapping==1
*sum z2_MSWS_12_change if All_data_mapping==1
*egen z2_FSS_change = std(FSS_change) if All_data_mapping==1
*sum z2_FSS_change if All_data_mapping==1


***NEED TO REGRESS CHANGE SCORE ON PROMs (IVs) AGAINST CHANGE SCORE ON EACH PBM (DV) IF All_data_PBMs==1

***THEN DO THE SAME FOR THE PROMS AND MAPPING ALGORITHMS IF All_data_mapping==1

***Use xtset and xtreg

***Need to do Hausman test

xtset UserId

xtreg EQ5D_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_PBMs==1

xtreg MSIS_8D_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_PBMs==1

xtreg MSIS_8D_P_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_PBMs==1

xtreg ICECAP_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_PBMs==1

xtreg ASCOT_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_PBMs==1



xtreg EQ5D_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1

xtreg MSIS_8D_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1

xtreg EQ5D_mapB_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1

xtreg EQ5D_mapF_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1

xtreg SF6D_mapB_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1

xtreg SF6D_mapF_change HADS_D_change HADS_A_change MSWS_12_change FSS_change if All_data_mapping==1
*/
