* SYNTAX FOR LONGITUDINAL ANALYSIS OF HSV AND WELLBEING DATA Part 1

version 15.1
cd "S:\ExeterWellbeingValue - Well being and Value - Exeter"
use "HUMS Workstream 2 Phase 3\WS2_data_ALL_PHASE_3_DATA.dta", replace

*******SYNTAX TO MERGE PHASE 3 WITH PHASE 1 AND PHASE 2 DATA*******

merge 1:1 UserId using "HUMS Workstream 2 Phase 2\PHASE 1 AND 2 DATA.dta", update
 
drop _merge

save "HUMS Workstream 2 Phase 3\PHASE 1 2 AND 3 DATA.dta", replace



******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
****************THIS THE DATA WRANGLING FOR THE PHASE 1 & 2 DATA WHICH WE'LL NEED LATER***************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************





***FIX PROBLEM WITH W00_MSWS12_00 CODING AND RECALCULATE MSWS-12 TOTAL SCORES

tab W00_MSWS12_00
tab FU1_MSWS12_00

drop W00_MSWS12_tot
drop W00_MSWS12_tot_r

label define walk1 0 "Cannot walk" 1 "Can walk"
label values W00_MSWS12_00 walk1
tab W00_MSWS12_00

mvdecode W00_MSWS12_00 W00_MSWS12_01 W00_MSWS12_02 W00_MSWS12_03 W00_MSWS12_04 W00_MSWS12_05 W00_MSWS12_06 ///
W00_MSWS12_07 W00_MSWS12_08 W00_MSWS12_09 W00_MSWS12_10 W00_MSWS12_11 W00_MSWS12_12, mv(999)

gen W00_MSWS12_tot = W00_MSWS12_00
replace W00_MSWS12_tot = (W00_MSWS12_01 + W00_MSWS12_02 + W00_MSWS12_03 + W00_MSWS12_04 + W00_MSWS12_05 + W00_MSWS12_06 ///
 + W00_MSWS12_07 + W00_MSWS12_08 + W00_MSWS12_09 + W00_MSWS12_10 + W00_MSWS12_11 + W00_MSWS12_12)

gen W00_MSWS12_tot_r=W00_MSWS12_tot
replace W00_MSWS12_tot_r=(100*(W00_MSWS12_tot-12))/42
replace W00_MSWS12_tot_r = 100 if W00_MSWS12_00==0

tab W00_MSWS12_tot_r
sum W00_MSWS12_tot_r if FU1_MSWS12_tot_r!=.


***CREATE CHANGE SCORES FOR PBMs, MAPPING ALGORITHMS AND WBMs***

*Calculate difference (ie change score) in MSIS-8D HSVs
gen MSIS_8D_W00_FU1 = FU1_MSIS_8D - W00_MSIS_8D
label var MSIS_8D_W00_FU1 "Difference in MSIS-8D phase 1 to 2"
tab MSIS_8D_W00_FU1

*Calculate difference (ie change score) in MSIS-8D-P HSVs
gen MSIS_8D_P_W00_FU1 = FU1_MSIS_8D_P - W00_MSIS_8D_P
label var MSIS_8D_P_W00_FU1 "Difference in MSIS-8D-P phase 1 to 2"
tab MSIS_8D_P_W00_FU1

*Calculate difference (ie change score) in EQ-5D HSVs
gen EQ5D_W00_FU1 = FU1_EQ5D_HSV - W00_EQ5D_HSV
label var EQ5D_W00_FU1 "Difference in EQ-5D phase 1 to 2"
tab EQ5D_W00_FU1

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model B)
gen EQ5D_mapB_W00_FU1 = FU1_EQ5D_mapB - W00_EQ5D_mapB
label var EQ5D_mapB_W00_FU1 "Difference in mapped EQ-5D HSVs (model B) phase 1 to 2"
tab EQ5D_mapB_W00_FU1

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model F)
gen EQ5D_mapF_W00_FU1 = FU1_EQ5D_mapF - W00_EQ5D_mapF
label var EQ5D_mapF_W00_FU1 "Difference in mapped EQ-5D HSVs (model F) phase 1 to 2"
tab EQ5D_mapF_W00_FU1

*Calculate difference (ie change score) in mapped SF-6D HSVs (model B)
gen SF6D_mapB_W00_FU1 = FU1_SF6D_mapB - W00_SF6D_mapB
label var SF6D_mapB_W00_FU1 "Difference in mapped SF-6D HSVs (model B) phase 1 to 2"
tab SF6D_mapB_W00_FU1

*Calculate difference (ie change score) in mapped SF-6D HSVs (model F)
gen SF6D_mapF_W00_FU1 = FU1_SF6D_mapF - W00_SF6D_mapF
label var SF6D_mapF_W00_FU1 "Difference in mapped SF-6D HSVs (model F) phase 1 to 2"
tab SF6D_mapF_W00_FU1

*Calculate difference (ie change score) in ICECAP-A WBVs
gen ICECAP_A_W00_FU1 = FU1_ICECAP_A_WBV - W00_ICECAP_A_WBV
label var ICECAP_A_W00_FU1 "Difference in ICECAP-A phase 1 to 2"
tab ICECAP_A_W00_FU1

*Calculate difference (ie change score) in ASCOT WBVs
gen ASCOT_W00_FU1 = FU1_ASCOT_WBV - W00_ASCOT_WBV
label var ASCOT_W00_FU1 "Difference in ASCOT phase 1 to 2"
tab ASCOT_W00_FU1



***CREATE CHANGE SCORES FOR PROMs***

*Calculate difference (ie change score) in HADS depression scores
gen HADS_depression_W00_FU1 = FU1_HADS_depression - W00_HADS_depression
label var HADS_depression_W00_FU1 "Difference in HADS depression phase 1 to 2"
tab HADS_depression_W00_FU1


*Calculate difference (ie change score) in HADS anxiety scores
gen HADS_anxiety_W00_FU1 = FU1_HADS_anxiety - W00_HADS_anxiety
replace HADS_anxiety_W00_FU1 = . if FU1_HADS_anxiety==.
label var HADS_anxiety_W00_FU1 "Difference in HADS anxiety phase 1 to 2"
tab HADS_anxiety_W00_FU1

*Calculate difference (ie change score) in MSWS-12 transformed scores
gen MSWS_tot_r_W00_FU1 = FU1_MSWS12_tot_r - W00_MSWS12_tot_r
replace MSWS_tot_r_W00_FU1 = . if (FU1_MSWS12_tot_r==. | W00_MSWS12_tot_r==.)
label var MSWS_tot_r_W00_FU1 "Difference in MSWS-12 transformed phase 1 to 2"
tab MSWS_tot_r_W00_FU1

*Calculate difference (ie change score) in FSS total scores
gen FSS_tot_W00_FU1 = FU1_FSS_tot - W00_FSS_tot
replace FSS_tot_W00_FU1 = . if (FU1_FSS_tot==. | W00_FSS_tot==.)
label var FSS_tot_W00_FU1 "Difference in FSS total phase 1 to 2"
tab FSS_tot_W00_FU1


***CREATE RESPONDENT GROUPS FOR THE PROMS***

label define groups 0 "No difference" 1 "Improvement" 2 "Deterioration"


***TRYING MIDS FOR THE MSWS-12

***MSWS-12 (transformed): MID = 6
*gen MSWS_group_W00_FU1_6 = MSWS_tot_r_W00_FU1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen MSWS_group_W00_FU1_6 = MSWS_tot_r_W00_FU1
replace MSWS_group_W00_FU1_6 = . if (W00_MSWS12_tot_r==. | FU1_MSWS12_tot_r==.)
replace MSWS_group_W00_FU1_6 = 0 if (MSWS_tot_r_W00_FU1>=-6 & MSWS_tot_r_W00_FU1<=6)
replace MSWS_group_W00_FU1_6 = 1 if MSWS_tot_r_W00_FU1<=-6
replace MSWS_group_W00_FU1_6 = 2 if (MSWS_tot_r_W00_FU1>=6 & MSWS_tot_r_W00_FU1<=100)
label values MSWS_group_W00_FU1_6 groups
tab MSWS_group_W00_FU1_6


***MSWS-12 (transformed): MID = 8
*gen MSWS_group_W00_FU1_8 = MSWS_tot_r_W00_FU1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen MSWS_group_W00_FU1_8 = MSWS_tot_r_W00_FU1
replace MSWS_group_W00_FU1_8 = . if (W00_MSWS12_tot_r==. | FU1_MSWS12_tot_r==.)
replace MSWS_group_W00_FU1_8 = 0 if (MSWS_tot_r_W00_FU1>=-8 & MSWS_tot_r_W00_FU1<=8)
replace MSWS_group_W00_FU1_8 = 1 if MSWS_tot_r_W00_FU1<=-8
replace MSWS_group_W00_FU1_8 = 2 if (MSWS_tot_r_W00_FU1>=8 & MSWS_tot_r_W00_FU1<=100)
label values MSWS_group_W00_FU1_8 groups
tab MSWS_group_W00_FU1_8


*HADS depression: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_D_group_W00_FU1 = HADS_depression_W00_FU1
replace HADS_D_group_W00_FU1 = . if (W00_HADS_depression==. | FU1_HADS_depression==.)
replace HADS_D_group_W00_FU1 = 0 if (HADS_depression_W00_FU1>=-2 & HADS_depression_W00_FU1<=2)
replace HADS_D_group_W00_FU1 = 1 if HADS_depression_W00_FU1<=-2
replace HADS_D_group_W00_FU1 = 2 if (HADS_depression_W00_FU1>=2 & HADS_depression_W00_FU1<=11)
label values HADS_D_group_W00_FU1 groups
tab HADS_D_group_W00_FU1


*HADS anxiety: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_A_group_W00_FU1 = HADS_anxiety_W00_FU1
replace HADS_A_group_W00_FU1 = 0 if (HADS_anxiety_W00_FU1>=-2 & HADS_anxiety_W00_FU1<=2)
replace HADS_A_group_W00_FU1 = 1 if HADS_anxiety_W00_FU1<=-2
replace HADS_A_group_W00_FU1 = 2 if (HADS_anxiety_W00_FU1>=2 & HADS_anxiety_W00_FU1<=13)
label values HADS_A_group_W00_FU1 groups
tab HADS_A_group_W00_FU1

*Fatigue severity scale: MID = 1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen FSS_group_W00_FU1 = FSS_tot_W00_FU1
replace FSS_group_W00_FU1 = 0 if (FSS_tot_W00_FU1>=-1 & FSS_tot_W00_FU1<=1)
replace FSS_group_W00_FU1 = 1 if FSS_tot_W00_FU1<=-1
replace FSS_group_W00_FU1 = 2 if (FSS_tot_W00_FU1>=1 & FSS_tot_W00_FU1<=5.8)
label values FSS_group_W00_FU1 groups
tab FSS_group_W00_FU1


***CREATE RESPONDENT GROUPS FOR EACH OF THE IREs WHERE NECESSARY***

*Start with the main IREs that do not directly identify where a change has occurred
*For now, leave the supplementary IRE questions that provide additional detail

*Note that inclusion of an "F" in the variable name denotes a filter question
*ie people giving a specific answer to this question did not complete the remainder of that section.
*Note that the suffix "a" denotes a subsidiary question, which was only answered if the respondent
*gave a particular answer to the previous question.

*For each main IRE, we need to identify 3 groups:
**Those who DID report the event at time T but who DID NOT at time T-1
**Those who DID NOT report the event at time T but who DID at time T-1
**Those who DID report the event at time T and at time T-1
**Those who DID NOT report the event at time T or at time T-1

*IEQ_Symptoms_1 "Currently experiencing new symptoms"
gen IEQ_Symptoms_1_W00_FU1 = .
replace IEQ_Symptoms_1_W00_FU1 = 1 if (W00_IEQ_Symptoms_1==1 & FU1_IEQ_Symptoms_1==2)
replace IEQ_Symptoms_1_W00_FU1 = 2 if (W00_IEQ_Symptoms_1==2 & FU1_IEQ_Symptoms_1==1)
replace IEQ_Symptoms_1_W00_FU1 = 3 if (W00_IEQ_Symptoms_1==1 & FU1_IEQ_Symptoms_1==1)
replace IEQ_Symptoms_1_W00_FU1 = 4 if (W00_IEQ_Symptoms_1==2 & FU1_IEQ_Symptoms_1==2)
label var IEQ_Symptoms_1_W00_FU1 "New symptoms phase 1 to 2"
label define yesno12 1 "P1 yes; P2 no" 2 "P1 no; P2 yes" 3 "P1 yes; P2 yes" 4 "P1 no; P2 no"
label values IEQ_Symptoms_1_W00_FU1 yesno12
tab IEQ_Symptoms_1_W00_FU1

*IEQ_Symptoms_2 "Currently experiencing complications or side-effects"
gen IEQ_Symptoms_2_W00_FU1 = .
replace IEQ_Symptoms_2_W00_FU1 = 1 if (W00_IEQ_Symptoms_2==1 & FU1_IEQ_Symptoms_2==2)
replace IEQ_Symptoms_2_W00_FU1 = 2 if (W00_IEQ_Symptoms_2==2 & FU1_IEQ_Symptoms_2==1)
replace IEQ_Symptoms_2_W00_FU1 = 3 if (W00_IEQ_Symptoms_2==1 & FU1_IEQ_Symptoms_2==1)
replace IEQ_Symptoms_2_W00_FU1 = 4 if (W00_IEQ_Symptoms_2==2 & FU1_IEQ_Symptoms_2==2)
label var IEQ_Symptoms_2_W00_FU1 "Complications/side effects phase 1 to 2"
label values IEQ_Symptoms_2_W00_FU1 yesno12
tab IEQ_Symptoms_2_W00_FU1

*IEQ_Treatments_F_3 "Any MS treatments in the last 6 months"
gen IEQ_Treatments_F_3_W00_FU1 = .
replace IEQ_Treatments_F_3_W00_FU1 = 1 if (W00_IEQ_Treatments_F_3==1 & FU1_IEQ_Treatments_F_3==2)
replace IEQ_Treatments_F_3_W00_FU1 = 2 if (W00_IEQ_Treatments_F_3==2 & FU1_IEQ_Treatments_F_3==1)
replace IEQ_Treatments_F_3_W00_FU1 = 3 if (W00_IEQ_Treatments_F_3==1 & FU1_IEQ_Treatments_F_3==1)
replace IEQ_Treatments_F_3_W00_FU1 = 4 if (W00_IEQ_Treatments_F_3==2 & FU1_IEQ_Treatments_F_3==2)
label var IEQ_Treatments_F_3_W00_FU1 "Any MS treatments phase 1 to 2"
label values IEQ_Treatments_F_3_W00_FU1 yesno12
tab IEQ_Treatments_F_3_W00_FU1

*IEQ_Treatments_4 "Started a drug treatment for MS symptoms"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Treatments_4

*IEQ_Treatments_5 "Stopped a drug treatment for MS symptoms"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Treatments_5

***FU1_IEQ_Treatments_5a "Reason for stopping drug treatment for MS symptoms"***
*Supplementary question
tab FU1_IEQ_Treatments_5a


*IEQ_Treatments_6 "Any DMT in the last 6 months"
gen IEQ_Treatments_6_W00_FU1 = .
replace IEQ_Treatments_6_W00_FU1 = 1 if (W00_IEQ_Treatments_6==1 & FU1_IEQ_Treatments_6==2)
replace IEQ_Treatments_6_W00_FU1 = 2 if (W00_IEQ_Treatments_6==2 & FU1_IEQ_Treatments_6==1)
replace IEQ_Treatments_6_W00_FU1 = 3 if (W00_IEQ_Treatments_6==1 & FU1_IEQ_Treatments_6==1)
replace IEQ_Treatments_6_W00_FU1 = 4 if (W00_IEQ_Treatments_6==2 & FU1_IEQ_Treatments_6==2)
label var IEQ_Treatments_6_W00_FU1 "Any DMT phase 1 to 2"
label values IEQ_Treatments_6_W00_FU1 yesno12
tab IEQ_Treatments_6_W00_FU1


*IEQ_Treatments_6a "Start, stop or take DMT throughout the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Treatments_6a


*IEQ_Treatments_7 "Started non-drug treatment for MS in the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Treatments_7


*IEQ_Treatments_8 "Stopped non-drug treatment for MS in the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Treatments_8


***FU1_IEQ_Treatments_8a "Reason for stopping non-drug treatment for MS"
*Supplementary question
tab FU1_IEQ_Treatments_8a


***IEQ_Services_9 "Any change in NHS or social care services"
*This is a filter question for FU1_IEQ_Services_9a

***FU1_IEQ_Services_9a "NHS or social care services better, same or worse"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Services_9a if W00_IEQ_Services_9==1

  
***IEQ_Services_10 "Any change in self-funded services"
*This is a filter question for FU1_IEQ_Services_10a

***FU1_IEQ_Services_10a "Self-funded services better, same or worse"
tab FU1_IEQ_Services_10a if FU1_IEQ_Services_10==1


*IEQ_Work_F_12 "Any paid work in the last 6 months"
gen IEQ_Work_F_12_W00_FU1 = .
replace IEQ_Work_F_12_W00_FU1 = 1 if (W00_IEQ_Work_F_12==1 & FU1_IEQ_Work_F_12==2)
replace IEQ_Work_F_12_W00_FU1 = 2 if (W00_IEQ_Work_F_12==2 & FU1_IEQ_Work_F_12==1)
replace IEQ_Work_F_12_W00_FU1 = 3 if (W00_IEQ_Work_F_12==1 & FU1_IEQ_Work_F_12==1)
replace IEQ_Work_F_12_W00_FU1 = 4 if (W00_IEQ_Work_F_12==2 & FU1_IEQ_Work_F_12==2)
label var IEQ_Work_F_12_W00_FU1 "Any paid work phase 1 to 2"
label values IEQ_Work_F_12_W00_FU1 yesno12
tab IEQ_Work_F_12_W00_FU1


*IEQ_Work_13 "Permanently left job"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Work_13

  
***FU1_IEQ_Work_13a "Did you want to leave your job?"
*Supplementary question
*tab FU1_IEQ_Work_13a


*FU1_IEQ_Work_14 "Changed job"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Work_14

  
***FU1_IEQ_Work_14a "Did you want to change your job?"
*Supplementary question
*tab FU1_IEQ_Work_14a

  
*IEQ_Work_15 "Reduced working hours"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU1_IEQ_Work_15

  
***FU1_IEQ_Work_15a "Did you want to reduce your hours?"
*Supplementary question
tab FU1_IEQ_Work_15a

  
*IEQ_Work_16 "Return to work after more than 4 weeks"
*No new variables necessary: this question specifically refer to a change in the last six months
tab FU1_IEQ_Work_16


***FU1_IEQ_Work_16a "Reason for returning to work"
*Supplementary question
*tab FU1_IEQ_Work_16a


***FU1_IEQ_Diagnosis_F_17 "Diagnosis of RRMS"
*This is a filter question for 17a
tab FU1_IEQ_Diagnosis_F_17


***FU1_IEQ_Diagnosis_17a "Change from RRMS to SPMS"
gen IEQ_Diagnosis_17a_W00_FU1 = .
replace IEQ_Diagnosis_17a_W00_FU1 = 2 if (W00_IEQ_Diagnosis_F_17==1 & FU1_IEQ_Diagnosis_F_17!=.)
replace IEQ_Diagnosis_17a_W00_FU1 = 1 if FU1_IEQ_Diagnosis_17a==1
label var IEQ_Diagnosis_17a_W00_FU1 "RRMS to SPMS phase 1 to 2"
label define diag 1 "Yes, changed to SPMS" 2 "No, still RRMS"
label values IEQ_Diagnosis_17a_W00_FU1 diag
tab IEQ_Diagnosis_17a_W00_FU1

*IEQ_Relapses_F_18 "Any MS relapses in the last 6 months"
gen IEQ_Relapses_F_18_W00_FU1 = .
replace IEQ_Relapses_F_18_W00_FU1 = 1 if (W00_IEQ_Relapses_F_18==1 & FU1_IEQ_Relapses_F_18==2)
replace IEQ_Relapses_F_18_W00_FU1 = 2 if (W00_IEQ_Relapses_F_18==2 & FU1_IEQ_Relapses_F_18==1)
replace IEQ_Relapses_F_18_W00_FU1 = 3 if (W00_IEQ_Relapses_F_18==1 & FU1_IEQ_Relapses_F_18==1)
replace IEQ_Relapses_F_18_W00_FU1 = 4 if (W00_IEQ_Relapses_F_18==2 & FU1_IEQ_Relapses_F_18==2)
label var IEQ_Relapses_F_18_W00_FU1 "Any MS relapses"
label values IEQ_Relapses_F_18_W00_FU1 yesno12
tab IEQ_Relapses_F_18_W00_FU1



******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
***************THIS IS WHERE THE PHASE 2 AND PHASE 3 DATA WRANGLING AND ANALYSIS STARTS***************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************
******************************************************************************************************







***CREATE CHANGE SCORES FOR PBMs, MAPPING ALGORITHMS AND WBMs FOR PHASE 2 AND PHASE 3***

*Calculate difference (ie change score) in MSIS-8D HSVs
gen MSIS_8D_FU1_FU2 = FU2_MSIS_8D - FU1_MSIS_8D
label var MSIS_8D_FU1_FU2 "Difference in MSIS-8D phase 2 to 3"
*tab MSIS_8D_FU1_FU2

*Calculate difference (ie change score) in MSIS-8D-P HSVs
gen MSIS_8D_P_FU1_FU2 = FU2_MSIS_8D_P - FU1_MSIS_8D_P
label var MSIS_8D_P_FU1_FU2 "Difference in MSIS-8D_P phase 2 to 3"
*tab MSIS_8D_P_FU1_FU2

*Calculate difference (ie change score) in EQ-5D HSVs
gen EQ5D_FU1_FU2 = FU2_EQ5D_HSV - FU1_EQ5D_HSV
label var EQ5D_FU1_FU2 "Difference in EQ-5D phase 2 to 3"
*tab EQ5D_FU1_FU2

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model B)
gen EQ5D_mapB_FU1_FU2 = FU2_EQ5D_mapB - FU1_EQ5D_mapB
label var EQ5D_mapB_FU1_FU2 "Difference mapped EQ-5D HSVs (model B) phase 2 to 3"
*tab EQ5D_mapB_FU1_FU2

*Calculate difference (ie change score) in mapped EQ-5D HSVs (model F)
gen EQ5D_mapF_FU1_FU2 = FU2_EQ5D_mapF - FU1_EQ5D_mapF
label var EQ5D_mapF_FU1_FU2 "Difference mapped EQ-5D HSVs (model F) phase 2 to 3"
*tab EQ5D_mapF_FU1_FU2

*Calculate difference (ie change score) in mapped SF-6D HSVs (model B)
gen SF6D_mapB_FU1_FU2 = FU2_SF6D_mapB - FU1_SF6D_mapB
label var SF6D_mapB_FU1_FU2 "Difference mapped SF-6D HSVs (model B) phase 2 to 3"
*tab SF6D_mapB_FU1_FU2

*Calculate difference (ie change score) in mapped SF-6D HSVs (model F)
gen SF6D_mapF_FU1_FU2 = FU2_SF6D_mapF - FU1_SF6D_mapF
label var SF6D_mapF_FU1_FU2 "Difference mapped SF-6D HSVs (model F) phase 2 to 3"
*tab SF6D_mapF_FU1_FU2

*Calculate difference (ie change score) in ICECAP-A WBVs
gen ICECAP_A_FU1_FU2 = FU2_ICECAP_A_WBV - FU1_ICECAP_A_WBV
label var ICECAP_A_FU1_FU2 "Difference in ICECAP-A phase 2 to 3"
*tab ICECAP_A_FU1_FU2

*Calculate difference (ie change score) in ASCOT WBVs
gen ASCOT_FU1_FU2 = FU2_ASCOT_WBV - FU1_ASCOT_WBV
label var ASCOT_FU1_FU2 "Difference in ASCOT phase 2 to 3"
*tab ASCOT_FU1_FU2



***CREATE CHANGE SCORES FOR PROMs FOR PHASE 2 AND PHASE 3***

*Calculate difference (ie change score) in HADS depression scores
gen HADS_depression_FU1_FU2 = FU2_HADS_depression - FU1_HADS_depression
replace HADS_depression_FU1_FU2 = . if (FU2_HADS_depression==. | FU1_HADS_depression==.)
label var HADS_depression_FU1_FU2 "Difference in HADS depression phase 2 to 3"
*tab HADS_depression_FU1_FU2


*Calculate difference (ie change score) in HADS anxiety scores
gen HADS_anxiety_FU1_FU2 = FU2_HADS_anxiety - FU1_HADS_anxiety
replace HADS_anxiety_FU1_FU2 = . if (FU2_HADS_anxiety==. | FU1_HADS_anxiety==.)
label var HADS_anxiety_FU1_FU2 "Difference in HADS anxiety phase 2 to 3"
*tab HADS_anxiety_FU1_FU2

*Calculate difference (ie change score) in MSWS-12 transformed scores
gen MSWS_tot_r_FU1_FU2 = FU2_MSWS12_tot_r - FU1_MSWS12_tot_r
replace MSWS_tot_r_FU1_FU2 = . if (FU2_MSWS12_tot_r==. | FU1_MSWS12_tot_r==.)
label var MSWS_tot_r_FU1_FU2 "Difference in MSWS-12 transformed phase 2 to 3"
*tab MSWS_tot_r_FU1_FU2

*Calculate difference (ie change score) in FSS total scores
gen FSS_tot_FU1_FU2 = FU2_FSS_tot - FU1_FSS_tot
replace FSS_tot_FU1_FU2 = . if (FU2_FSS_tot==. | FU1_FSS_tot==.)
label var FSS_tot_FU1_FU2 "Difference in FSS total phase 2 to 3"
*tab FSS_tot_FU1_FU2


***CREATE RESPONDENT GROUPS FOR THE PROMS FOR PHASE 2 AND PHASE 3***

***MSWS-12 (transformed): MID = 6
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen MSWS_group_FU1_FU2_6 = MSWS_tot_r_FU1_FU2
replace MSWS_group_FU1_FU2_6 = . if (FU1_MSWS12_tot_r==. | FU2_MSWS12_tot_r==.)
replace MSWS_group_FU1_FU2_6 = 0 if (MSWS_tot_r_FU1_FU2>=-6 & MSWS_tot_r_FU1_FU2<=6)
replace MSWS_group_FU1_FU2_6 = 1 if MSWS_tot_r_FU1_FU2<=-6
replace MSWS_group_FU1_FU2_6 = 2 if (MSWS_tot_r_FU1_FU2>=6 & MSWS_tot_r_FU1_FU2<=100)
label values MSWS_group_FU1_FU2_6 groups
tab MSWS_group_FU1_FU2_6


***MSWS-12 (transformed): MID = 8
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen MSWS_group_FU1_FU2_8 = MSWS_tot_r_FU1_FU2
replace MSWS_group_FU1_FU2_8 = . if (FU1_MSWS12_tot_r==. | FU2_MSWS12_tot_r==.)
replace MSWS_group_FU1_FU2_8 = 0 if (MSWS_tot_r_FU1_FU2>=-8 & MSWS_tot_r_FU1_FU2<=8)
replace MSWS_group_FU1_FU2_8 = 1 if MSWS_tot_r_FU1_FU2<=-8
replace MSWS_group_FU1_FU2_8 = 2 if (MSWS_tot_r_FU1_FU2>=8 & MSWS_tot_r_FU1_FU2<=100)
label values MSWS_group_FU1_FU2_8 groups
tab MSWS_group_FU1_FU2_8


*HADS depression: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_D_group_FU1_FU2 = HADS_depression_FU1_FU2
replace HADS_D_group_FU1_FU2 = . if (FU1_HADS_depression==. | FU2_HADS_depression==.)
replace HADS_D_group_FU1_FU2 = 0 if (HADS_depression_FU1_FU2>=-2 & HADS_depression_FU1_FU2<=2)
replace HADS_D_group_FU1_FU2 = 1 if HADS_depression_FU1_FU2<=-2
replace HADS_D_group_FU1_FU2 = 2 if (HADS_depression_FU1_FU2>=2 & HADS_depression_FU1_FU2<=9)
label values HADS_D_group_FU1_FU2 groups
tab HADS_D_group_FU1_FU2


*HADS anxiety: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_A_group_FU1_FU2 = HADS_anxiety_FU1_FU2
replace HADS_A_group_FU1_FU2 = . if (FU1_HADS_anxiety==. | FU2_HADS_anxiety==.)
replace HADS_A_group_FU1_FU2 = 0 if (HADS_anxiety_FU1_FU2>=-2 & HADS_anxiety_FU1_FU2<=2)
replace HADS_A_group_FU1_FU2 = 1 if HADS_anxiety_FU1_FU2<=-2
replace HADS_A_group_FU1_FU2 = 2 if (HADS_anxiety_FU1_FU2>=2 & HADS_anxiety_FU1_FU2<=12)
label values HADS_A_group_FU1_FU2 groups
tab HADS_A_group_FU1_FU2


*Fatigue severity scale: MID = 1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen FSS_group_FU1_FU2 = FSS_tot_FU1_FU2
replace FSS_group_FU1_FU2 = . if (FU1_FSS_tot==. | FU2_FSS_tot==.)
replace FSS_group_FU1_FU2 = 0 if (FSS_tot_FU1_FU2>=-1 & FSS_tot_FU1_FU2<=1)
replace FSS_group_FU1_FU2 = 1 if FSS_tot_FU1_FU2<=-1
replace FSS_group_FU1_FU2 = 2 if (FSS_tot_FU1_FU2>=1.0 & FSS_tot_FU1_FU2<=5.8)
label values FSS_group_FU1_FU2 groups
tab FSS_group_FU1_FU2


***CREATE RESPONDENT GROUPS FOR EACH OF THE IREs WHERE NECESSARY FOR PHASE 2 AND PHASE 3***

*Start with the main IREs that do not directly identify where a change has occurred
*For now, leave the supplementary IRE questions that provide additional detail

*Note that inclusion of an "F" in the variable name denotes a filter question
*ie people giving a specific answer to this question did not complete the remainder of that section.
*Note that the suffix "a" denotes a subsidiary question, which was only answered if the respondent
*gave a particular answer to the previous question.

*For each main IRE, we need to identify 3 groups:
**Those who DID report the event at time T but who DID NOT at time T-1
**Those who DID NOT report the event at time T but who DID at time T-1
**Those who DID report the event at time T and at time T-1
**Those who DID NOT report the event at time T or at time T-1

*IEQ_Symptoms_1 "Currently experiencing new symptoms"
gen IEQ_Symptoms_1_FU1_FU2 = .
replace IEQ_Symptoms_1_FU1_FU2 = 1 if (FU1_IEQ_Symptoms_1==1 & FU2_IEQ_Symptoms_1==2)
replace IEQ_Symptoms_1_FU1_FU2 = 2 if (FU1_IEQ_Symptoms_1==2 & FU2_IEQ_Symptoms_1==1)
replace IEQ_Symptoms_1_FU1_FU2 = 3 if (FU1_IEQ_Symptoms_1==1 & FU2_IEQ_Symptoms_1==1)
replace IEQ_Symptoms_1_FU1_FU2 = 4 if (FU1_IEQ_Symptoms_1==2 & FU2_IEQ_Symptoms_1==2)
label var IEQ_Symptoms_1_FU1_FU2 "New symptoms phase 2 to 3"
label define yesno23 1 "P2 yes; P3 no" 2 "P2 no; P3 yes" 3 "P2 yes; P3 yes" 4 "P2 no; P3 no"
label values IEQ_Symptoms_1_FU1_FU2 yesno23
tab IEQ_Symptoms_1_FU1_FU2

*IEQ_Symptoms_2 "Currently experiencing complications or side-effects"
gen IEQ_Symptoms_2_FU1_FU2 = .
replace IEQ_Symptoms_2_FU1_FU2 = 1 if (FU1_IEQ_Symptoms_2==1 & FU2_IEQ_Symptoms_2==2)
replace IEQ_Symptoms_2_FU1_FU2 = 2 if (FU1_IEQ_Symptoms_2==2 & FU2_IEQ_Symptoms_2==1)
replace IEQ_Symptoms_2_FU1_FU2 = 3 if (FU1_IEQ_Symptoms_2==1 & FU2_IEQ_Symptoms_2==1)
replace IEQ_Symptoms_2_FU1_FU2 = 4 if (FU1_IEQ_Symptoms_2==2 & FU2_IEQ_Symptoms_2==2)
label var IEQ_Symptoms_2_FU1_FU2 "Complications/side effects phase 2 to 3"
label values IEQ_Symptoms_2_FU1_FU2 yesno23
tab IEQ_Symptoms_2_FU1_FU2


*IEQ_Treatments_F_3 "Any MS treatments in the last 6 months"
gen IEQ_Treatments_F_3_FU1_FU2 = .
replace IEQ_Treatments_F_3_FU1_FU2 = 1 if (FU1_IEQ_Treatments_F_3==1 & FU2_IEQ_Treatments_F_3==2)
replace IEQ_Treatments_F_3_FU1_FU2 = 2 if (FU1_IEQ_Treatments_F_3==2 & FU2_IEQ_Treatments_F_3==1)
replace IEQ_Treatments_F_3_FU1_FU2 = 3 if (FU1_IEQ_Treatments_F_3==1 & FU2_IEQ_Treatments_F_3==1)
replace IEQ_Treatments_F_3_FU1_FU2 = 4 if (FU1_IEQ_Treatments_F_3==2 & FU2_IEQ_Treatments_F_3==2)
label var IEQ_Treatments_F_3_FU1_FU2 "Any MS treatments phase 2 to 3"
label values IEQ_Treatments_F_3_FU1_FU2 yesno23
tab IEQ_Treatments_F_3_FU1_FU2


*IEQ_Treatments_4 "Started a drug treatment for MS symptoms"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Treatments_4

*IEQ_Treatments_5 "Stopped a drug treatment for MS symptoms"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Treatments_5

***FU1_IEQ_Treatments_5a "Reason for stopping drug treatment for MS symptoms"***
*Supplementary question
tab FU2_IEQ_Treatments_5a


*IEQ_Treatments_6 "Any DMT in the last 6 months"
gen IEQ_Treatments_6_FU1_FU2 = .
replace IEQ_Treatments_6_FU1_FU2 = 1 if (FU1_IEQ_Treatments_6==1 & FU2_IEQ_Treatments_6==2)
replace IEQ_Treatments_6_FU1_FU2 = 2 if (FU1_IEQ_Treatments_6==2 & FU2_IEQ_Treatments_6==1)
replace IEQ_Treatments_6_FU1_FU2 = 3 if (FU1_IEQ_Treatments_6==1 & FU2_IEQ_Treatments_6==1)
replace IEQ_Treatments_6_FU1_FU2 = 4 if (FU1_IEQ_Treatments_6==2 & FU2_IEQ_Treatments_6==2)
label var IEQ_Treatments_6_FU1_FU2 "Any DMT phase 2 to 3"
label values IEQ_Treatments_6_FU1_FU2 yesno23
tab IEQ_Treatments_6_FU1_FU2


*IEQ_Treatments_6a "Start, stop or take DMT throughout the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Treatments_6a


*IEQ_Treatments_7 "Started non-drug treatment for MS in the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Treatments_7


*IEQ_Treatments_8 "Stopped non-drug treatment for MS in the last 6 months"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Treatments_8


***FU2_IEQ_Treatments_8a "Reason for stopping non-drug treatment for MS"
*Supplementary question
tab FU2_IEQ_Treatments_8a


***IEQ_Services_9 "Any change in NHS or social care services"
*This is a filter question for FU2_IEQ_Services_9a

***FU2_IEQ_Services_9a "NHS or social care services better, same or worse"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Services_9a if W00_IEQ_Services_9==1

  
***IEQ_Services_10 "Any change in self-funded services"
*This is a filter question for FU2_IEQ_Services_10a

***FU2_IEQ_Services_10a "Self-funded services better, same or worse"
tab FU2_IEQ_Services_10a if FU1_IEQ_Services_10==1


*IEQ_Work_F_12 "Any paid work in the last 6 months"
gen IEQ_Work_F_12_FU1_FU2 = .
replace IEQ_Work_F_12_FU1_FU2 = 1 if (FU1_IEQ_Work_F_12==1 & FU2_IEQ_Work_F_12==2)
replace IEQ_Work_F_12_FU1_FU2 = 2 if (FU1_IEQ_Work_F_12==2 & FU2_IEQ_Work_F_12==1)
replace IEQ_Work_F_12_FU1_FU2 = 3 if (FU1_IEQ_Work_F_12==1 & FU2_IEQ_Work_F_12==1)
replace IEQ_Work_F_12_FU1_FU2 = 4 if (FU1_IEQ_Work_F_12==2 & FU2_IEQ_Work_F_12==2)
label var IEQ_Work_F_12_FU1_FU2 "Any paid work phase 2 to 3"
label values IEQ_Work_F_12_FU1_FU2 yesno23
tab IEQ_Work_F_12_FU1_FU2


*IEQ_Work_13 "Permanently left job"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Work_13

  
***FU2_IEQ_Work_13a "Did you want to leave your job?"
*Supplementary question
*tab FU2_IEQ_Work_13a


*FU2_IEQ_Work_14 "Changed job"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Work_14

  
***FU2_IEQ_Work_14a "Did you want to change your job?"
*Supplementary question
*tab FU2_IEQ_Work_14a

  
*IEQ_Work_15 "Reduced working hours"
*No new variables necessary: this question specifically refers to a change in the last six months
tab FU2_IEQ_Work_15

  
***FU2_IEQ_Work_15a "Did you want to reduce your hours?"
*Supplementary question
tab FU2_IEQ_Work_15a

  
*IEQ_Work_16 "Return to work after more than 4 weeks"
*No new variables necessary: this question specifically refer to a change in the last six months
tab FU2_IEQ_Work_16


***FU2_IEQ_Work_16a "Reason for returning to work"
*Supplementary question
*tab FU2_IEQ_Work_16a


***FU2_IEQ_Diagnosis_F_17 "Diagnosis of RRMS"
*This is a filter question for 17a
tab FU2_IEQ_Diagnosis_F_17


***FU1_IEQ_Diagnosis_17a "Change from RRMS to SPMS"
gen IEQ_Diagnosis_17a_FU1_FU2 = .
replace IEQ_Diagnosis_17a_FU1_FU2 = 2 if (FU1_IEQ_Diagnosis_F_17==1 & FU2_IEQ_Diagnosis_F_17!=.)
replace IEQ_Diagnosis_17a_FU1_FU2 = 1 if FU2_IEQ_Diagnosis_17a==1
label var IEQ_Diagnosis_17a_FU1_FU2 "RRMS to SPMS phase 2 to 3"
label values IEQ_Diagnosis_17a_FU1_FU2 diag
tab IEQ_Diagnosis_17a_FU1_FU2


*IEQ_Relapses_F_18 "Any MS relapses in the last 6 months"
gen IEQ_Relapses_F_18_FU1_FU2 = .
replace IEQ_Relapses_F_18_FU1_FU2 = 1 if (FU1_IEQ_Relapses_F_18==1 & FU2_IEQ_Relapses_F_18==2)
replace IEQ_Relapses_F_18_FU1_FU2 = 2 if (FU1_IEQ_Relapses_F_18==2 & FU2_IEQ_Relapses_F_18==1)
replace IEQ_Relapses_F_18_FU1_FU2 = 3 if (FU1_IEQ_Relapses_F_18==1 & FU2_IEQ_Relapses_F_18==1)
replace IEQ_Relapses_F_18_FU1_FU2 = 4 if (FU1_IEQ_Relapses_F_18==2 & FU2_IEQ_Relapses_F_18==2)
label var IEQ_Relapses_F_18_FU1_FU2 "Any relapses phase 2 to 3"
label values IEQ_Relapses_F_18_FU1_FU2 yesno23
tab IEQ_Relapses_F_18_FU1_FU2


 
  
****************************************************************************************************

********************DESCRIPTIVES FOR RESPONDENTS PROVIDING DATA*************************************
***************************AT BOTH DATA COLLECTION POINTS*******************************************

********SYNTAX FOR PHASE 2 TO PHASE 3 ANALYSIS********

***Descriptives at Phase 2 (FU1) for Phase 2 and Phase 3 analysis

sum FU1_Age if FU2_Age!=.
tab FU1_MSTypeNow if FU2_MSTypeNow!=.

sum FU1_MSIS29_phys if FU2_MSIS29_phys!=.
sum FU1_MSIS29_psyc if FU2_MSIS29_psyc!=.
tab FU1_MSWS12_00 if FU2_MSWS12_00!=.
sum FU1_MSWS12_tot_r if FU2_MSWS12_tot_r!=.
sum FU1_FSS_tot if FU2_FSS_tot!=.
sum FU1_HADS_depression if FU2_HADS_depression!=.
sum FU1_HADS_anxiety if FU2_HADS_anxiety!=.

sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
sum FU1_MSIS_8D if FU2_MSIS_8D!=.
sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.
histogram FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
histogram FU1_MSIS_8D if FU2_MSIS_8D!=.
histogram FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.
histogram FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
histogram FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
histogram FU1_SF6D_mapB if FU2_SF6D_mapB!=.
histogram FU1_SF6D_mapF if FU2_SF6D_mapF!=.

sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.
sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
sum FU1_WEMWBS_tot if FU2_WEMWBS_tot!=.
histogram FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.
histogram FU1_ICECAP_A_WBV if FU2_ASCOT_WBV!=.
histogram FU1_WEMWBS_tot if FU2_WEMWBS_tot!=.


***Descriptives at Phase 3 (FU2) for Phase 2 and Phase 3 analysis

sum FU2_Age if FU1_Age!=.
tab FU2_MSTypeNow if FU1_MSTypeNow!=.

sum FU2_MSIS29_phys if FU1_MSIS29_phys!=.
sum FU2_MSIS29_psyc if FU1_MSIS29_psyc!=.
tab FU2_MSWS12_00 if FU1_MSWS12_00!=.
sum FU2_MSWS12_tot_r if FU1_MSWS12_tot_r!=.
sum FU2_FSS_tot if FU1_FSS_tot!=.
sum FU2_HADS_depression if FU1_HADS_depression!=.
sum FU2_HADS_anxiety if FU1_HADS_anxiety!=.

sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
sum FU2_MSIS_8D if FU1_MSIS_8D!=.
sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.
histogram FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
histogram FU2_MSIS_8D if FU1_MSIS_8D!=.
histogram FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.
histogram FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
histogram FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
histogram FU2_SF6D_mapB if FU1_SF6D_mapB!=.
histogram FU2_SF6D_mapF if FU1_SF6D_mapF!=.

sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.
sum FU2_ICECAP_A_WBV if FU1_ASCOT_WBV!=.
sum FU2_WEMWBS_tot if FU1_WEMWBS_tot!=.
histogram FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.
histogram FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
histogram FU2_WEMWBS_tot if FU1_WEMWBS_tot!=.



****************************************************************************************************



***MEAN CHANGE SCORES***
*These should give the means and SDs of the change scores

** Mean change scores for those with and without a significant difference (MID = 6) in MSWS-12 scores

sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_6==0

sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_6==2
sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_6==1
sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_6==0


** Mean change scores  for those with and without a significant difference (MID = 8) in MSWS-12 scores

sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum MSIS_8D_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum MSIS_8D_P_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum EQ5D_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum EQ5D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum EQ5D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum SF6D_mapB_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum SF6D_mapF_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum ICECAP_A_FU1_FU2 if MSWS_group_FU1_FU2_8==0

sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_8==2
sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_8==1
sum ASCOT_FU1_FU2 if MSWS_group_FU1_FU2_8==0


** Mean change scores for those with and without a significant difference in HADS depression scores

sum MSIS_8D_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum MSIS_8D_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum MSIS_8D_P_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum MSIS_8D_P_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum EQ5D_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum EQ5D_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum EQ5D_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum EQ5D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum EQ5D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum EQ5D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum EQ5D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum SF6D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum SF6D_mapB_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum SF6D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum SF6D_mapF_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum ICECAP_A_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum ICECAP_A_FU1_FU2 if HADS_D_group_FU1_FU2==0

sum ASCOT_FU1_FU2 if HADS_D_group_FU1_FU2==2
sum ASCOT_FU1_FU2 if HADS_D_group_FU1_FU2==1
sum ASCOT_FU1_FU2 if HADS_D_group_FU1_FU2==0


** Mean change scores for those with and without a significant difference in HADS anxiety scores

sum MSIS_8D_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum MSIS_8D_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum MSIS_8D_P_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum MSIS_8D_P_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum EQ5D_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum EQ5D_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum EQ5D_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum EQ5D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum EQ5D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum EQ5D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum EQ5D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum SF6D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum SF6D_mapB_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum SF6D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum SF6D_mapF_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum ICECAP_A_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum ICECAP_A_FU1_FU2 if HADS_A_group_FU1_FU2==0

sum ASCOT_FU1_FU2 if HADS_A_group_FU1_FU2==2
sum ASCOT_FU1_FU2 if HADS_A_group_FU1_FU2==1
sum ASCOT_FU1_FU2 if HADS_A_group_FU1_FU2==0


** Mean change scores for those with and without a significant difference in FSS scores

sum MSIS_8D_FU1_FU2 if FSS_group_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if FSS_group_FU1_FU2==1
sum MSIS_8D_FU1_FU2 if FSS_group_FU1_FU2==0

sum MSIS_8D_P_FU1_FU2 if FSS_group_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if FSS_group_FU1_FU2==1
sum MSIS_8D_P_FU1_FU2 if FSS_group_FU1_FU2==0

sum EQ5D_FU1_FU2 if FSS_group_FU1_FU2==2
sum EQ5D_FU1_FU2 if FSS_group_FU1_FU2==1
sum EQ5D_FU1_FU2 if FSS_group_FU1_FU2==0

sum EQ5D_mapB_FU1_FU2 if FSS_group_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if FSS_group_FU1_FU2==1
sum EQ5D_mapB_FU1_FU2 if FSS_group_FU1_FU2==0

sum EQ5D_mapF_FU1_FU2 if FSS_group_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if FSS_group_FU1_FU2==1
sum EQ5D_mapF_FU1_FU2 if FSS_group_FU1_FU2==0

sum SF6D_mapB_FU1_FU2 if FSS_group_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if FSS_group_FU1_FU2==1
sum SF6D_mapB_FU1_FU2 if FSS_group_FU1_FU2==0

sum SF6D_mapF_FU1_FU2 if FSS_group_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if FSS_group_FU1_FU2==1
sum SF6D_mapF_FU1_FU2 if FSS_group_FU1_FU2==0

sum ICECAP_A_FU1_FU2 if FSS_group_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if FSS_group_FU1_FU2==1
sum ICECAP_A_FU1_FU2 if FSS_group_FU1_FU2==0

sum ASCOT_FU1_FU2 if FSS_group_FU1_FU2==2
sum ASCOT_FU1_FU2 if FSS_group_FU1_FU2==1
sum ASCOT_FU1_FU2 if FSS_group_FU1_FU2==0


** Mean change scores for those with and without a change in experiencing new symptoms (IEQ-1)

sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum EQ5D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum EQ5D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==4
sum ASCOT_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==3
sum ASCOT_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Symptoms_1_FU1_FU2==1


** Mean change scores for those with and without a change in complications or side-effects (IEQ-2)

sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum EQ5D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum EQ5D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==4
sum ASCOT_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==3
sum ASCOT_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Symptoms_2_FU1_FU2==1


** Mean change scores for those with and without a change in whether they received any treatment (IEQ-3)

sum MSIS_8D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum MSIS_8D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum MSIS_8D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum MSIS_8D_P_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum MSIS_8D_P_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum EQ5D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum EQ5D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum EQ5D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum EQ5D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum EQ5D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum EQ5D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum SF6D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum SF6D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum SF6D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum SF6D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum ICECAP_A_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum ICECAP_A_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==4
sum ASCOT_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==3
sum ASCOT_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Treatments_F_3_FU1_FU2==1


** Mean change scores for those who did or did not start a drug treatment for MS symptoms (IEQ-4)

sum MSIS_8D_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum MSIS_8D_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum MSIS_8D_P_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum MSIS_8D_P_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum EQ5D_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum EQ5D_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum EQ5D_mapB_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum EQ5D_mapB_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum EQ5D_mapF_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum EQ5D_mapF_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum SF6D_mapB_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum SF6D_mapB_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum SF6D_mapF_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum SF6D_mapF_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum ICECAP_A_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum ICECAP_A_FU1_FU2 if FU2_IEQ_Treatments_4==1

sum ASCOT_FU1_FU2 if FU2_IEQ_Treatments_4==2
sum ASCOT_FU1_FU2 if FU2_IEQ_Treatments_4==1


**There were too few responses to each category of IEQ-5a to undertake analysis

**There were too few responses to each category of IEQ-6a to undertake analysis


** Mean change scores for those who did or did not start a non-drug treatment for MS (IEQ-7)

sum MSIS_8D_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum MSIS_8D_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum MSIS_8D_P_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum MSIS_8D_P_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum EQ5D_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum EQ5D_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum EQ5D_mapB_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum EQ5D_mapB_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum EQ5D_mapF_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum EQ5D_mapF_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum SF6D_mapB_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum SF6D_mapB_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum SF6D_mapF_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum SF6D_mapF_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum ICECAP_A_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum ICECAP_A_FU1_FU2 if FU2_IEQ_Treatments_7==1

sum ASCOT_FU1_FU2 if FU2_IEQ_Treatments_7==2
sum ASCOT_FU1_FU2 if FU2_IEQ_Treatments_7==1


** Mean change scores for those with a change in social care services (IEQ-9a)
*1 = Better, 2 = Same, 3 = Worse

sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)

sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==3)
sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==2)
sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_9==1 & FU2_IEQ_Services_9a==1)


** Mean change scores for those with a change in self-funded services (IEQ-10a)
*1 = Better, 2 = Same, 3 = Worse

sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum MSIS_8D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum MSIS_8D_P_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum EQ5D_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum EQ5D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum EQ5D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum SF6D_mapB_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum SF6D_mapF_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum ICECAP_A_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)

sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==3)
sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==2)
sum ASCOT_FU1_FU2 if (FU2_IEQ_Services_10==1 & FU2_IEQ_Services_10a==1)



** Mean change scores for those with and without a change in whether they undertook any paid work (IEQ-12)

sum MSIS_8D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum MSIS_8D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum MSIS_8D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum MSIS_8D_P_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum MSIS_8D_P_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum EQ5D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum EQ5D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum EQ5D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum EQ5D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum EQ5D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum EQ5D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum SF6D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum SF6D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum SF6D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum SF6D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum ICECAP_A_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum ICECAP_A_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==4
sum ASCOT_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==3
sum ASCOT_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Work_F_12_FU1_FU2==1


**There were too few responses to each category of IEQ-13 to undertake analysis

**There were too few responses to each category of IEQ-14 to undertake analysis

**There were too few responses to each category of IEQ-15a to undertake analysis

**There were too few responses to each category of IEQ-16 to undertake analysis

**There were too few responses to each category of IEQ-16a to undertake analysis


** Mean change scores for those who continued with diagnosis of RRMS and those who progressed to SPMS (IEQ-17; 17a)

sum MSIS_8D_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Diagnosis_17a_FU1_FU2==1


** Mean change scores for those with and without a change in whether they experienced any MS relapses (IEQ-18)

sum MSIS_8D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum MSIS_8D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum MSIS_8D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum MSIS_8D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum MSIS_8D_P_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum MSIS_8D_P_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum MSIS_8D_P_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum MSIS_8D_P_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum EQ5D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum EQ5D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum EQ5D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum EQ5D_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum EQ5D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum EQ5D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum EQ5D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum EQ5D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum EQ5D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum EQ5D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum EQ5D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum EQ5D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum SF6D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum SF6D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum SF6D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum SF6D_mapB_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum SF6D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum SF6D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum SF6D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum SF6D_mapF_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum ICECAP_A_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum ICECAP_A_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum ICECAP_A_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum ICECAP_A_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1

sum ASCOT_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==4
sum ASCOT_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==3
sum ASCOT_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==2
sum ASCOT_FU1_FU2 if IEQ_Relapses_F_18_FU1_FU2==1


********************************************************************************************************************
*****************************************STATS AT EACH TIMEPOINT****************************************************
********************************************************************************************************************

*These should give the mean value, SD, etc for each HSV/WBV source at each time-point for each respondent group

**for those with and without a significant difference (MID=6) in MSWS-12 scores

bysort MSWS_group_FU1_FU2_6: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort MSWS_group_FU1_FU2_6: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort MSWS_group_FU1_FU2_6: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort MSWS_group_FU1_FU2_6: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort MSWS_group_FU1_FU2_6: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort MSWS_group_FU1_FU2_6: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort MSWS_group_FU1_FU2_6: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort MSWS_group_FU1_FU2_6: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a significant difference (MID=8) in MSWS-12 scores

bysort MSWS_group_FU1_FU2_8: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort MSWS_group_FU1_FU2_8: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort MSWS_group_FU1_FU2_8: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort MSWS_group_FU1_FU2_8: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort MSWS_group_FU1_FU2_8: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort MSWS_group_FU1_FU2_8: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort MSWS_group_FU1_FU2_8: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort MSWS_group_FU1_FU2_8: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a significant difference in HADS depression scores

bysort HADS_D_group_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort HADS_D_group_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort HADS_D_group_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort HADS_D_group_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort HADS_D_group_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort HADS_D_group_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort HADS_D_group_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort HADS_D_group_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort HADS_D_group_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort HADS_D_group_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort HADS_D_group_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort HADS_D_group_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort HADS_D_group_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort HADS_D_group_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort HADS_D_group_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort HADS_D_group_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort HADS_D_group_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort HADS_D_group_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a significant difference in HADS anxiety scores

bysort HADS_A_group_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort HADS_A_group_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort HADS_A_group_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort HADS_A_group_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort HADS_A_group_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort HADS_A_group_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort HADS_A_group_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort HADS_A_group_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort HADS_A_group_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort HADS_A_group_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort HADS_A_group_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort HADS_A_group_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort HADS_A_group_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort HADS_A_group_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort HADS_A_group_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort HADS_A_group_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort HADS_A_group_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort HADS_A_group_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a significant difference in FSS scores

bysort FSS_group_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort FSS_group_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort FSS_group_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort FSS_group_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort FSS_group_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort FSS_group_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort FSS_group_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort FSS_group_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort FSS_group_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort FSS_group_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort FSS_group_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort FSS_group_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort FSS_group_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort FSS_group_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort FSS_group_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort FSS_group_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort FSS_group_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort FSS_group_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in whether they are experiencing new symptoms (IEQ1)

bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Symptoms_1_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in whether they are experiencing complications or side-effects (IEQ2)

bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Symptoms_2_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in whether they are receiving any treatments for MS (IEQ3)

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Treatments_F_3_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those who have and have not started receiving drug treatment for MS symptoms (IEQ4)

bysort FU2_IEQ_Treatments_4: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort FU2_IEQ_Treatments_4: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort FU2_IEQ_Treatments_4: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort FU2_IEQ_Treatments_4: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort FU2_IEQ_Treatments_4: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort FU2_IEQ_Treatments_4: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort FU2_IEQ_Treatments_4: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort FU2_IEQ_Treatments_4: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort FU2_IEQ_Treatments_4: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort FU2_IEQ_Treatments_4: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort FU2_IEQ_Treatments_4: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort FU2_IEQ_Treatments_4: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort FU2_IEQ_Treatments_4: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort FU2_IEQ_Treatments_4: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort FU2_IEQ_Treatments_4: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort FU2_IEQ_Treatments_4: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort FU2_IEQ_Treatments_4: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort FU2_IEQ_Treatments_4: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those who have and have not started receiving non-drug treatment for MS (IEQ7)

bysort FU2_IEQ_Treatments_7: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort FU2_IEQ_Treatments_7: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort FU2_IEQ_Treatments_7: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort FU2_IEQ_Treatments_7: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort FU2_IEQ_Treatments_7: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort FU2_IEQ_Treatments_7: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort FU2_IEQ_Treatments_7: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort FU2_IEQ_Treatments_7: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort FU2_IEQ_Treatments_7: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort FU2_IEQ_Treatments_7: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort FU2_IEQ_Treatments_7: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort FU2_IEQ_Treatments_7: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort FU2_IEQ_Treatments_7: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort FU2_IEQ_Treatments_7: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort FU2_IEQ_Treatments_7: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort FU2_IEQ_Treatments_7: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort FU2_IEQ_Treatments_7: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort FU2_IEQ_Treatments_7: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in social care services (IEQ9a)

bysort FU2_IEQ_Services_9a: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort FU2_IEQ_Services_9a: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort FU2_IEQ_Services_9a: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort FU2_IEQ_Services_9a: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort FU2_IEQ_Services_9a: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort FU2_IEQ_Services_9a: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort FU2_IEQ_Services_9a: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort FU2_IEQ_Services_9a: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort FU2_IEQ_Services_9a: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort FU2_IEQ_Services_9a: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort FU2_IEQ_Services_9a: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort FU2_IEQ_Services_9a: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort FU2_IEQ_Services_9a: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort FU2_IEQ_Services_9a: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort FU2_IEQ_Services_9a: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort FU2_IEQ_Services_9a: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort FU2_IEQ_Services_9a: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort FU2_IEQ_Services_9a: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in self-funded services (IEQ10a)

bysort FU2_IEQ_Services_10a: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort FU2_IEQ_Services_10a: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort FU2_IEQ_Services_10a: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort FU2_IEQ_Services_10a: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort FU2_IEQ_Services_10a: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort FU2_IEQ_Services_10a: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort FU2_IEQ_Services_10a: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort FU2_IEQ_Services_10a: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort FU2_IEQ_Services_10a: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort FU2_IEQ_Services_10a: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort FU2_IEQ_Services_10a: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort FU2_IEQ_Services_10a: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort FU2_IEQ_Services_10a: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort FU2_IEQ_Services_10a: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort FU2_IEQ_Services_10a: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort FU2_IEQ_Services_10a: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort FU2_IEQ_Services_10a: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort FU2_IEQ_Services_10a: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those with and without a change in whether they undertook any paid work (IEQ12)

bysort IEQ_Work_F_12_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Work_F_12_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Work_F_12_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Work_F_12_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Work_F_12_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Work_F_12_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Work_F_12_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those who continued with a diagnosis of RRMS and who changed to SPMS (IEQ17a)

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Diagnosis_17a_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.


**for those who did and did not have a relapse (IEQ18)

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_EQ5D_HSV if FU2_EQ5D_HSV!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_MSIS_8D if FU2_MSIS_8D!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_MSIS_8D_P if FU2_MSIS_8D_P!=.

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_EQ5D_mapB if FU2_EQ5D_mapB!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_EQ5D_mapF if FU2_EQ5D_mapF!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_SF6D_mapB if FU2_SF6D_mapB!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_SF6D_mapF if FU2_SF6D_mapF!=.

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_ICECAP_A_WBV if FU2_ICECAP_A_WBV!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU1_ASCOT_WBV if FU2_ASCOT_WBV!=.

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_EQ5D_HSV if FU1_EQ5D_HSV!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_MSIS_8D if FU1_MSIS_8D!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_MSIS_8D_P if FU1_MSIS_8D_P!=.

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_EQ5D_mapB if FU1_EQ5D_mapB!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_EQ5D_mapF if FU1_EQ5D_mapF!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_SF6D_mapB if FU1_SF6D_mapB!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_SF6D_mapF if FU1_SF6D_mapF!=.

bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_ICECAP_A_WBV if FU1_ICECAP_A_WBV!=.
bysort IEQ_Relapses_F_18_FU1_FU2: sum FU2_ASCOT_WBV if FU1_ASCOT_WBV!=.



********************************************************************************************
****************************************T-TESTS*********************************************
********************************************************************************************



*****statistical significance of the differences between time points assessed using t-tests

***t-tests for those with and without a significant difference (MID=6) in MSWS-12 scores

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_6==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_6==1
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_6==0

ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_6==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_6==1
ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_6==0

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_6==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_6==1
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_6==0

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_6==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_6==1
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_6==0

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_6==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_6==1
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_6==0

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_6==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_6==1
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_6==0

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_6==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_6==1
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_6==0

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_6==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_6==1
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_6==0

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_6==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_6==1
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_6==0


***t-tests for those with and without a significant difference (MID=8) in MSWS-12 scores

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_8==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_8==1
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if MSWS_group_FU1_FU2_8==0

ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_8==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_8==1
ttest FU1_MSIS_8D == FU2_MSIS_8D if MSWS_group_FU1_FU2_8==0

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_8==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_8==1
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if MSWS_group_FU1_FU2_8==0

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_8==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_8==1
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if MSWS_group_FU1_FU2_8==0

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_8==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_8==1
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if MSWS_group_FU1_FU2_8==0

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_8==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_8==1
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if MSWS_group_FU1_FU2_8==0

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_8==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_8==1
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if MSWS_group_FU1_FU2_8==0

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_8==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_8==1
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if MSWS_group_FU1_FU2_8==0

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_8==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_8==1
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if MSWS_group_FU1_FU2_8==0


***t-tests for those with and without a significant difference in HADS depression scores

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_D_group_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_D_group_FU1_FU2==1
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_D_group_FU1_FU2==0

ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_D_group_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_D_group_FU1_FU2==1
ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_D_group_FU1_FU2==0

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_D_group_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_D_group_FU1_FU2==1
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_D_group_FU1_FU2==0

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_D_group_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_D_group_FU1_FU2==1
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_D_group_FU1_FU2==0

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_D_group_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_D_group_FU1_FU2==1
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_D_group_FU1_FU2==0

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_D_group_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_D_group_FU1_FU2==1
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_D_group_FU1_FU2==0

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_D_group_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_D_group_FU1_FU2==1
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_D_group_FU1_FU2==0

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_D_group_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_D_group_FU1_FU2==1
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_D_group_FU1_FU2==0

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_D_group_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_D_group_FU1_FU2==1
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_D_group_FU1_FU2==0


***t-tests for those with and without a significant difference in HADS anxiety scores

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_A_group_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_A_group_FU1_FU2==1
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if HADS_A_group_FU1_FU2==0

ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_A_group_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_A_group_FU1_FU2==1
ttest FU1_MSIS_8D == FU2_MSIS_8D if HADS_A_group_FU1_FU2==0

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_A_group_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_A_group_FU1_FU2==1
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if HADS_A_group_FU1_FU2==0

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_A_group_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_A_group_FU1_FU2==1
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if HADS_A_group_FU1_FU2==0

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_A_group_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_A_group_FU1_FU2==1
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if HADS_A_group_FU1_FU2==0

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_A_group_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_A_group_FU1_FU2==1
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if HADS_A_group_FU1_FU2==0

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_A_group_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_A_group_FU1_FU2==1
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if HADS_A_group_FU1_FU2==0

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_A_group_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_A_group_FU1_FU2==1
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if HADS_A_group_FU1_FU2==0

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_A_group_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_A_group_FU1_FU2==1
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if HADS_A_group_FU1_FU2==0


***t-tests for those with and without a significant difference in FSS scores

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FSS_group_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FSS_group_FU1_FU2==1
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FSS_group_FU1_FU2==0

ttest FU1_MSIS_8D == FU2_MSIS_8D if FSS_group_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if FSS_group_FU1_FU2==1
ttest FU1_MSIS_8D == FU2_MSIS_8D if FSS_group_FU1_FU2==0

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FSS_group_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FSS_group_FU1_FU2==1
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FSS_group_FU1_FU2==0

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FSS_group_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FSS_group_FU1_FU2==1
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FSS_group_FU1_FU2==0

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FSS_group_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FSS_group_FU1_FU2==1
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FSS_group_FU1_FU2==0

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FSS_group_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FSS_group_FU1_FU2==1
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FSS_group_FU1_FU2==0

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FSS_group_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FSS_group_FU1_FU2==1
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FSS_group_FU1_FU2==0

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FSS_group_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FSS_group_FU1_FU2==1
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FSS_group_FU1_FU2==0

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FSS_group_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FSS_group_FU1_FU2==1
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FSS_group_FU1_FU2==0


***t-tests for those with and without a change in experiencing new symptoms (IEQ1)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_1_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_1_FU1_FU2==4
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_1_FU1_FU2==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_1_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_1_FU1_FU2==1


***t-tests for those with and without a change in experiencing new symptoms (IEQ2)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Symptoms_2_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_2_FU1_FU2==4
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_2_FU1_FU2==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_2_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Symptoms_2_FU1_FU2==1


***t-tests for those with and without a change in receiving any MS treatment (IEQ3)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Treatments_F_3_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Treatments_F_3_FU1_FU2==4
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Treatments_F_3_FU1_FU2==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Treatments_F_3_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Treatments_F_3_FU1_FU2==1


***t-tests for those who did and did not start a drug treatment for MS symptoms (IEQ4)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Treatments_4==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Treatments_4==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Treatments_4==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Treatments_4==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Treatments_4==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Treatments_4==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Treatments_4==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Treatments_4==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Treatments_4==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Treatments_4==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Treatments_4==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Treatments_4==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Treatments_4==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Treatments_4==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Treatments_4==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Treatments_4==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Treatments_4==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Treatments_4==1


***t-tests for those who did and did not start a non-drug treatment for MS (IEQ7)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Treatments_7==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Treatments_7==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Treatments_7==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Treatments_7==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Treatments_7==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Treatments_7==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Treatments_7==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Treatments_7==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Treatments_7==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Treatments_7==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Treatments_7==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Treatments_7==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Treatments_7==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Treatments_7==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Treatments_7==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Treatments_7==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Treatments_7==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Treatments_7==1


***t-tests for those with a change in social care services (IEQ9a)
* 1 "Better" 2 "Same" 3 "Worse"

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_9a==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_9a==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_9a==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_9a==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_9a==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_9a==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_9a==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_9a==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_9a==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_9a==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_9a==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_9a==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_9a==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_9a==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_9a==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_9a==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_9a==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_9a==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_9a==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_9a==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_9a==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_9a==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_9a==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_9a==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_9a==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_9a==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_9a==1


***t-tests for those with a change in self-funded services (IEQ10a)
* 1 "Better" 2 "Same" 3 "Worse"

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_10a==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_10a==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if FU2_IEQ_Services_10a==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_10a==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_10a==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if FU2_IEQ_Services_10a==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_10a==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_10a==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if FU2_IEQ_Services_10a==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_10a==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_10a==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if FU2_IEQ_Services_10a==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_10a==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_10a==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if FU2_IEQ_Services_10a==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_10a==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_10a==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if FU2_IEQ_Services_10a==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_10a==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_10a==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if FU2_IEQ_Services_10a==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_10a==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_10a==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if FU2_IEQ_Services_10a==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_10a==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_10a==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if FU2_IEQ_Services_10a==1


***t-tests for those with and without a change in undertaking any paid work (IEQ12)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Work_F_12_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Work_F_12_FU1_FU2==4
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Work_F_12_FU1_FU2==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Work_F_12_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Work_F_12_FU1_FU2==1


***t-tests for those who continued with a diagnosis of RRMS and who changed to SPMS (IEQ17a)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Diagnosis_17a_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Diagnosis_17a_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Diagnosis_17a_FU1_FU2==1


***t-tests for those with and without a change in whether they had any relapses (IEQ18)

ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_EQ5D_HSV == FU2_EQ5D_HSV if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_MSIS_8D == FU2_MSIS_8D if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_MSIS_8D_P == FU2_MSIS_8D_P if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_EQ5D_mapB == FU2_EQ5D_mapB if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_EQ5D_mapF == FU2_EQ5D_mapF if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_SF6D_mapB == FU2_SF6D_mapB if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_SF6D_mapF == FU2_SF6D_mapF if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_ICECAP_A_WBV == FU2_ICECAP_A_WBV if IEQ_Relapses_F_18_FU1_FU2==1

ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Relapses_F_18_FU1_FU2==4
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Relapses_F_18_FU1_FU2==3
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Relapses_F_18_FU1_FU2==2
ttest FU1_ASCOT_WBV == FU2_ASCOT_WBV if IEQ_Relapses_F_18_FU1_FU2==1






********************************************************************************
******************REPEAT PROMS ANALYSIS FOR PHASE 1 TO PHASE 3******************
********************************************************************************
****************TWO CONSECUTIVE CHANGES IN THE SAME DIRECTION*******************
********************************************************************************

**IDENTIFY RESPONDENTS WITH TWO CONSECUTIVE IMPROVEMENTS OR DETERIORATIONS**


***CREATE RESPONDENT GROUPS FOR THE PROMS FOR PHASE 1 TO PHASE 3***

**THESE IDENTIFY PEOPLE WITH >MID CHANGE BETWEEN PH1-PH2 AND BETWEEN PH2-PH3

***MSWS-12 (transformed): MID = 6
*gen MSWS_group_W00_FU1_6 = MSWS_tot_r_W00_FU1
gen MSWS_group_W00_FU2_6 = 0
replace MSWS_group_W00_FU2_6 = . if (MSWS_group_W00_FU1_6==. | MSWS_group_FU1_FU2_6==.)
replace MSWS_group_W00_FU2_6 = 1 if (MSWS_group_W00_FU1_6==1 & MSWS_group_FU1_FU2_6==1)
replace MSWS_group_W00_FU2_6 = 2 if (MSWS_group_W00_FU1_6==2 & MSWS_group_FU1_FU2_6==2)
label values MSWS_group_W00_FU2_6 groups
tab MSWS_group_W00_FU2_6


***MSWS-12 (transformed): MID = 8
*gen MSWS_group_W00_FU1_8 = MSWS_tot_r_W00_FU1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen MSWS_group_W00_FU2_8 = 0
replace MSWS_group_W00_FU2_8 = . if (MSWS_group_W00_FU1_8==. | MSWS_group_FU1_FU2_8==.)
replace MSWS_group_W00_FU2_8 = 1 if (MSWS_group_W00_FU1_8==1 & MSWS_group_FU1_FU2_8==1)
replace MSWS_group_W00_FU2_8 = 2 if (MSWS_group_W00_FU1_8==2 & MSWS_group_FU1_FU2_8==2)
label values MSWS_group_W00_FU2_8 groups
tab MSWS_group_W00_FU2_8


*HADS depression: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_D_group_W00_FU2 = 0
replace HADS_D_group_W00_FU2 = . if (HADS_D_group_W00_FU1==. | HADS_D_group_FU1_FU2==.)
replace HADS_D_group_W00_FU2 = 1 if (HADS_D_group_W00_FU1==1 & HADS_D_group_FU1_FU2==1)
replace HADS_D_group_W00_FU2 = 2 if (HADS_D_group_W00_FU1==2 & HADS_D_group_FU1_FU2==2)
label values HADS_D_group_W00_FU2 groups
tab HADS_D_group_W00_FU2


*HADS anxiety: MID = 2
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen HADS_A_group_W00_FU2 = 0
replace HADS_A_group_W00_FU2 = . if (HADS_A_group_W00_FU1==. | HADS_A_group_FU1_FU2==.)
replace HADS_A_group_W00_FU2 = 1 if (HADS_A_group_W00_FU1==1 & HADS_A_group_FU1_FU2==1)
replace HADS_A_group_W00_FU2 = 2 if (HADS_A_group_W00_FU1==2 & HADS_A_group_FU1_FU2==2)
label values HADS_A_group_W00_FU2 groups
tab HADS_A_group_W00_FU2

*Fatigue severity scale: MID = 1
*Higher scores indicate greater severity, therefore a positive change indicates deterioration
*and a negative change indicates improvement
gen FSS_group_W00_FU2 = 0
replace FSS_group_W00_FU2 = . if (FSS_group_W00_FU1==. | FSS_group_FU1_FU2==.)
replace FSS_group_W00_FU2 = 1 if (FSS_group_W00_FU1==1 & FSS_group_FU1_FU2==1)
replace FSS_group_W00_FU2 = 2 if (FSS_group_W00_FU1==2 & FSS_group_FU1_FU2==2)
label values FSS_group_W00_FU2 groups
tab FSS_group_W00_FU2


****NUMBERS IN EACH GROUP ARE TOO SMALL FOR ANALYSIS, SO DON'T BOTHER TAKING THIS FURTHER
drop MSWS_group_W00_FU2_6 MSWS_group_W00_FU2_8 HADS_D_group_W00_FU2 HADS_A_group_W00_FU2 FSS_group_W00_FU2



****************************************************************************************************
********************IDENTIFY WHICH RESPONDENTS PROVIDED ALL PBM AND PROM DATA***********************
****************************AT ALL DATA COLLECTION POINTS*******************************************
****************************************************************************************************
*** 1 = DID PROVIDE ALL DATA; 0 = DID NOT

****************************************************************************************************
* First, for PBMs and wellbeing measures
****************************************************************************************************
* New version created in regression do-file which includes the responses from 2 consecutive timepoints
* (So individuals can have none, only T1-2, only T2-3, or T1-2 and T2-3)

****************************************************************************************************
*Second, for mapping algorithms
****************************************************************************************************
gen All_data_mapping = 1
replace All_data_mapping = 0 if (W00_MSWS12_tot_r==. | FU1_MSWS12_tot_r==. | FU2_MSWS12_tot_r==.)
replace All_data_mapping = 0 if (W00_HADS_depression==. | FU1_HADS_depression==. | FU2_HADS_depression==.)
replace All_data_mapping = 0 if (W00_HADS_anxiety==. | FU1_HADS_anxiety==. | FU2_HADS_anxiety==.)
replace All_data_mapping = 0 if (W00_FSS_tot==. | FU1_FSS_tot==. | FU2_FSS_tot==.)
replace All_data_mapping = 0 if (W00_EQ5D_HSV==. | FU1_EQ5D_HSV==. | FU2_EQ5D_HSV==.)
replace All_data_mapping = 0 if (W00_MSIS_8D==. | FU1_MSIS_8D==. | FU2_MSIS_8D==.)
replace All_data_mapping = 0 if (W00_EQ5D_mapB==. | FU1_EQ5D_mapB==. | FU2_EQ5D_mapB==.)
replace All_data_mapping = 0 if (W00_EQ5D_mapF==. | FU1_EQ5D_mapF==. | FU2_EQ5D_mapF==.)
replace All_data_mapping = 0 if (W00_SF6D_mapB==. | FU1_SF6D_mapB==. | FU2_SF6D_mapB==.)
replace All_data_mapping = 0 if (W00_SF6D_mapF==. | FU1_SF6D_mapF==. | FU2_SF6D_mapF==.)
label define all_data 0 "No" 1 "Yes"
label values All_data_mapping all_data

*Descriptive statistics at baseline for respondents with all data for PBMs and mapping algorithms analysis
sum W00_Age if All_data_mapping==1
tab W00_MSTypeNow if All_data_mapping==1
tab Gender if All_data_mapping==1
sum W00_MSIS29_phys if All_data_mapping==1
sum W00_MSIS29_psyc if All_data_mapping==1
sum W00_MSWS12_tot_r if All_data_mapping==1
sum W00_FSS_tot if All_data_mapping==1
sum W00_HADS_depression if All_data_mapping==1
sum W00_HADS_anxiety if All_data_mapping==1

sum W00_EQ5D_HSV if All_data_mapping==1
sum W00_MSIS_8D if All_data_mapping==1

sum W00_EQ5D_mapB if All_data_mapping==1
sum W00_EQ5D_mapF if All_data_mapping==1
sum W00_SF6D_mapB if All_data_mapping==1
sum W00_SF6D_mapF if All_data_mapping==1

* Illness events questionnaire is filtered using reshaped data in regression do-file

****************************************************************************************************
* Save data for further analysis (e.g. regression)
****************************************************************************************************
save "HUMS Workstream 2 Phase 3\PHASE 1 2 AND 3 DATA LongitudinalGroups.dta", replace
