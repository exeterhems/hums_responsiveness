* SYNTAX FOR LONGITUDINAL ANALYSIS OF HSV AND WELLBEING DATA - Bonferroni and ranking
* Amy Heather July 2021

version 15.1
cd "S:\ExeterWellbeingValue - Well being and Value - Exeter"
import excel "HUMS Workstream 2 Phase 3\Results\FullResultsTable", firstrow sheet("Main") clear

* SES (mean change over baseline SD)
gen SES = MeanChange / SD1

* SES version 2 (mean change over average SD)
gen SESav = MeanChange / sqrt((SD1^2 + SD2^2)/2)

* Bonferroni correction
gen CorrectedSigLevel = 0.05 / _N
gen Sig = 1 if punadj <= CorrectedSigLevel
replace Sig = 2 if punadj > CorrectedSigLevel
label var Sig "Significant after Bonferroni correction?"
label define yesno 1 "Yes" 2 "No"
label values Sig yesno

* Column indicating if sample size < 30 for that row
gen SmallSample = 1 if Obs < 30
replace SmallSample = 2 if Obs >= 30
label var SmallSample "Is n<30?"
label values SmallSample yesno

* Columns indicating if PROM or IEQ
gen GroupOverall = "PROM"
replace GroupOverall = "IEQ" if strpos(Group, "IEQ")>0

* Ranking
* Field produces rank where 1 is given to highest value, and track where 1 is to lowest
bysort Group Subgroup Timepoint: egen Rank1HighMeanChange = rank(MeanChange), field
bysort Group Subgroup Timepoint: egen Rank1LowMeanChange = rank(MeanChange), track
bysort Group Subgroup Timepoint: egen Rank1HighSRM = rank(SRM), field
bysort Group Subgroup Timepoint: egen Rank1LowSRM = rank(SRM), track
bysort Group Subgroup Timepoint: egen Rank1HighSES = rank(SES), field
bysort Group Subgroup Timepoint: egen Rank1LowSES = rank(SES), track
bysort Group Subgroup Timepoint: egen Rank1HighSESav = rank(SESav), field
bysort Group Subgroup Timepoint: egen Rank1LowSESav = rank(SESav), track

* Indicate whether 1 should be the highest value or the lowest value
gen LowHigh = "NA"

* For PROMs, want 1 for lowest when deterioration change (subgroup 2) and 1 for highest when improvement (subgroup 1)
replace LowHigh = "Low" if Subgroup == 2 & GroupOverall == "PROM"
replace LowHigh = "High" if Subgroup == 1 & GroupOverall == "PROM"

* VARIABLES WHERE 1 MEANS IMPROVE AND 2 MEANS DETERIORATE
* IEQ_Symptoms_1 (new symptom): 1 improve (1 yes, 2 no), 2 deteriorate (1 no, 2 yes), 3/4 no change
* IEQ_Symptoms_2 (complication/side effect): 1 improve (1 yes, 2 no), 2 deteriorate (1 no, 2 yes), 3/4 no change
* IEQ_Relapses_F_18 (any MS relapses in last 6 month): 1 improve (1 yes, 2 no), 2 deteriorate (1 no, 2 yes), 3/4 no change
* IEQ_Work_16 (return to work after more than 4 weeks): 1 improve (1 yes) 2 deteriorate (2 no)
local 1imp2det ///
	IEQ_Symptoms_1_W00_FU1 IEQ_Symptoms_1_FU1_FU2 ///
	IEQ_Symptoms_2_W00_FU1 IEQ_Symptoms_2_FU1_FU2 ///
	IEQ_Relapses_F_18_W00_FU1 IEQ_Relapses_F_18_FU1_FU2 ///
	FU1_IEQ_Work_16 FU2_IEQ_Work_16
foreach v in `1imp2det' {
	replace LowHigh = "High" if Subgroup == 1 & Group == "`v'"
	replace LowHigh = "Low" if Subgroup == 2 & Group == "`v'"
}

* VARIABLES WHERE 1 MEANS DETERIORATE AND 2 MEANS IMPROVE
* IEQ_Treatments_3 (any MS treatments): 1 deteriorate (1 yes, 2 no), 2 improve (2 no, 1 yes), 3/4 no change
* IEQ_Treatments_6 (any DMT): 1 deteriorate (1 yes, 2 no), 2 improve (2 no, 1 yes), 3/4 no change
* IEQ_Work_F_12 (any paid work in last 6 month): 1 deteriorate (1 yes, 2 no), 2 improve (2 no, 1 yes), 3/4 no change
local 1det2imp ///
	IEQ_Treatments_F_3_W00_FU1 IEQ_Treatments_F_3_FU1_FU2 ///
	IEQ_Treatments_6_W00_FU1 IEQ_Treatments_6_FU1_FU2 ///
	IEQ_Work_F_12_W00_FU1 IEQ_Work_F_12_FU1_FU2
foreach v in `1det2imp' {
	replace LowHigh = "Low" if Subgroup == 1 & Group == "`v'"
	replace LowHigh = "High" if Subgroup == 2 & Group == "`v'"
}

* VARIABLES WHERE 1 MEANS IMPROVE AND 2 MEANS NO CHANGE
* IEQ_Treatments_4 (started a drug treatment for MS in last 6 month): 1 improve (1 yes) 2 no change (2 no)
* IEQ_Treatments_7 (started non-drug treatment for MS in last 6 month): 1 improve (1 yes) 2 no change (2 no)
local 1imp2no ///
	FU1_IEQ_Treatments_4 FU2_IEQ_Treatments_4 ///
	FU1_IEQ_Treatments_7 FU2_IEQ_Treatments_7
foreach v in `1imp2no' {
	replace LowHigh = "High" if Subgroup == 1 & Group == "`v'"
}

* VARIABLES WHERE 1 MEANS DETERIORATE AND 2 MEANS NO CHANGE
* IEQ_Treatments_5 (stopped a drug treatment for MS in last 6 month): 1 deteriorate (1 yes) 2 no change (2 no)
* IEQ_Treatments_8 (stopped non-drug treatment for MS in last 6 month): 1 deteriorate (1 yes) 2 no change (2 no)
* IEQ_Work_13 (permanently left job because of MS): 1 deteriorate (1 yes), 2 no change (2 no)
* IEQ_Work_14 (changed job because of MS): 1 deteriorate (1 yes), 2 no change (2 no)
* IEQ_Work_15 (reduced working hours): 1 deteriorate (1 yes) 2 no change (2 no)
* IEQ_Diagnosis_17a (RRMS to SPMS): 1 deteriorate (1 yes changed to SPMS), 2 no change (2 no still RRMS)
local 1det2no ///
	FU1_IEQ_Treatments_5 FU2_IEQ_Treatments_5 ///
	FU1_IEQ_Treatments_8 FU2_IEQ_Treatments_8 ///
	FU1_IEQ_Work_13 FU2_IEQ_Work_13 ///
	FU1_IEQ_Work_14 FU2_IEQ_Work_14 ///
	FU1_IEQ_Work_15 FU2_IEQ_Work_15 ///
	IEQ_Diagnosis_17a_W00_FU1 IEQ_Diagnosis_17a_FU1_FU2
foreach v in `1det2no' {
	replace LowHigh = "Low" if Subgroup == 1 & Group == "`v'"
}

* VARIABLES WHERE 2 MEANS IMPROVE AND 3 MEANS DETERIORATE (AND 1 AND 4 ARE N/A)
* IEQ_Treatments_6a (DMT in last 6 months...): 2 improve (2 start), 3 deteriorate (3 stop), 1/4 n/a (1 throughout, 4 switch)
local 2imp3det ///
	FU1_IEQ_Treatments_6a FU2_IEQ_Treatments_6a
foreach v in `2imp3det' {
	replace LowHigh = "High" if Subgroup == 2 & Group == "`v'"
	replace LowHigh = "Low" if Subgroup == 3 & Group == "`v'"
}

* VARIABLES WHERE 1 MEANS IMPROVE, 2 MEANS NO CHANGE AND 3 MEANS DETERIORATE
* IEQ_Services_9a (NHS or social care services better, same or worse): 1 improve (1 better), 3 deteriorate (3 worse), 2 no change (2 same)
* IEQ_Services_10a (self-funded services better, same or worse): 1 improve (1 better), 3 deteriorate (3 worse), 2 no change (2 same)
local 1imp3det ///
	FU1_IEQ_Services_9a FU2_IEQ_Services_9a ///
	FU1_IEQ_Services_10a FU2_IEQ_Services_10a
foreach v in `1imp3det' {
	replace LowHigh = "High" if Subgroup == 1 & Group == "`v'"
	replace LowHigh = "Low" if Subgroup == 3 & Group == "`v'"
}	

* Fill in each rank with appropriate high/low rank
gen RankMeanChange = .
gen RankSRM = .
gen RankSES = .
gen RankSESav = .
replace RankMeanChange = Rank1LowMeanChange if LowHigh == "Low"
replace RankMeanChange = Rank1HighMeanChange if LowHigh == "High"
replace RankSRM = Rank1LowSRM if LowHigh == "Low"
replace RankSRM = Rank1HighSRM if LowHigh == "High"
replace RankSES = Rank1LowSES if LowHigh == "Low"
replace RankSES = Rank1HighSES if LowHigh == "High"
replace RankSESav = Rank1LowSESav if LowHigh == "Low"
replace RankSESav = Rank1HighSESav if LowHigh == "High"

* Save updated results
export excel "HUMS Workstream 2 Phase 3\Results\FullResultsTableAdditional.xlsx", firstrow(var) sheet("Main") replace

*******************************************************************************
* Median rank
*******************************************************************************
* Median rank for each measure
preserve
collapse (median) MedianRankMeanChange=RankMeanChange ///
	(median) MedianRankSRM=RankSRM ///
	(median) MedianRankSES=RankSES ///
	(median) MedianRankSESav=RankSESav, ///
	by(Measure)
list
export excel "HUMS Workstream 2 Phase 3\Results\MedianRank.xlsx", firstrow(var) sheet("Overall") replace
restore

* Median rank for each measure by timepoint
preserve
collapse (median) MedianRankMeanChange=RankMeanChange ///
	(median) MedianRankSRM=RankSRM ///
	(median) MedianRankSES=RankSES ///
	(median) MedianRankSESav=RankSESav, ///
	by(Measure Timepoint)
list
export excel "HUMS Workstream 2 Phase 3\Results\MedianRank.xlsx", firstrow(var) sheet("ByTimepoint")
restore

* Median rank for each measure by whether PROMS or IEQ
preserve
collapse (median) MedianRankMeanChange=RankMeanChange ///
	(median) MedianRankSRM=RankSRM ///
	(median) MedianRankSES=RankSES ///
	(median) MedianRankSESav=RankSESav, ///
	by(Measure GroupOverall)
sort GroupOverall Measure
list
export excel "HUMS Workstream 2 Phase 3\Results\MedianRank.xlsx", firstrow(var) sheet("ByGroup")
restore

* Median rank for each measure by timepoint and whether PROMS or IEQ
preserve
collapse (median) MedianRankMeanChange=RankMeanChange ///
	(median) MedianRankSRM=RankSRM ///
	(median) MedianRankSES=RankSES ///
	(median) MedianRankSESav=RankSESav, ///
	by(Measure Timepoint GroupOverall)
sort Timepoint GroupOverall Measure
list
export excel "HUMS Workstream 2 Phase 3\Results\MedianRank.xlsx", firstrow(var) sheet("ByTimepointAndGroup")
restore
