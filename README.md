<h1 align="center">
  <br>
    <a href="https://medicine.exeter.ac.uk/health-community/research/healtheconomics/"><img src="https://raw.githubusercontent.com/exeterhems/hums_responsiveness/main/images/exeter_economics.png" alt="Health Economics Group, University of Exeter"></a>
  <br>
  Health Utilities in MS (HUMS) Responsiveness Paper
  <br>
</h1>

<p align="center">
    <a target="_blank" href="https://www.stata.com/"><img src="https://img.shields.io/badge/software-Stata_v17-239120" alt="Software"/></a>
    <a href="#"><img src="https://img.shields.io/github/last-commit/exeterhems/hums_responsiveness" alt="GitHub last commit" /></a>
    <a target="_blank" href="https://github.com/exeterhems/hums_responsiveness/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightblue.svg" alt="MIT licence"/></a>
    <a href="#"><img src="https://img.shields.io/github/v/release/exeterhems/hums_responsiveness" alt="GitHub last release" /></a>
    <a target="_blank" href="https://doi.org/10.5281/zenodo.15095009"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.15095009.svg" alt="DOI"/></a>
</p>

This repository contains Stata do-files from the analysis performed for:

> **Comparative responsiveness of preference-based health-related quality of life, social care and wellbeing, condition-specific and generic measures in the context of multiple sclerosis**
> 
> Elizabeth Goodwin, Amy Heather, Nia Morrish, Jenny Freeman, Kate Boddy, Sarah Thomas, Jeremy Chataway, Rod Middleton, Annie Hawton

This is a draft paper currently being submit to journal/s to consider for publication.

<br>

## ⚙️ Pre-processing

The provided do-files analyse data from the **UK MS Register**. Analysis was performed in **Stata version 17** which is a paid software, so a Stata license would be required to run these files.

Prior to analysis, the data underwent pre-processing in do-files 1 to 12 (not provided). These contain basic syntax:

* To ensure that responses were correctly coded.
* To calculate total scale/subscale scores for PROMs and utility values for PBMs
* To merge data from the 10 extracts provided by the UKMSR (a separate extract was provided for each measure and for demographics) into a single dataset
* To ensure that the dataset for analysis included all register members who provided data at two consecutive time-points (Time-points 1 and 2, and/or Time-points 2 and 3)
* To generate descriptive statistics for included participants.

<br>

## 📜 Data description

Whilst the data used in this analysis cannot be provided in this repository, we do offer a description of it below.

After the pre-processing above, we have two `.dta` files, which we use in the analysis below (with do-file 13 starting by merging these files).

**Filename:** *“HUMS Workstream 2 Phase 3\WS2_data_ALL_PHASE_3_DATA.dta”*

Person level data; one row per person.

Columns:

* Item-level responses and total scale/subscale scores for each PROM at Time-point 3.
* Item-level responses and utility values for each PBM at Time-point 3.
* Item-level responses to each IEQ question at Time-point 3.

**Filename:** *“HUMS Workstream 2 Phase 2\PHASE 1 AND 2 DATA.dta”*

Person level data; one row per person.

Columns:

* Item-level responses and total scale/subscale scores for each PROM at Time-point 1.
* Item-level responses and utility values for each PBM at Time-point 1.
* Item-level responses to each IEQ question at Time-point 1.
* Item-level responses and total scale/subscale scores for each PROM at Time-point 2.
* Item-level responses and utility values for each PBM at Time-point 2.
* Item-level responses to each IEQ question at Time-point 2.

<br>

## 🔍 Analysis

The analysis is described in detail in the publication. However, as a brief recap, the analysis in the do-files in this repository includes:

* `13 Syntax for WS2 longitudinal analysis all phases 20210113.do`
  * Calculate change in utility values for each preference-based measure (PBM) and patient-reported outcome measure (PROM) between each timepoint
  * Identify minimally important differences (MID) in PROMS
  * Identify illness-related events (IRE) from changes in illness-events questionnaire (IEQ)
  * Calculate population descriptives (e.g. age, MS type, utility values)
  * Summarise change in utility values (mean and standard deviation (SD)) in MID PROM group and IRE group 
  * Check for statistical significance in changes using t-tests
* `14 Longitudinal analysis all phases regression.do`
  * Additional processing (e.g. standardised PBMs and PROMs, recoding to set base case)
  * Hausman test and Breusch-Pagan Lagrange multiplier (LM) to determine whether random effects is appropriate
  * Pooled OLS regression on PBMs with continuous or categorical PROMs and with IEQ
  * Check regression assumptions (no outliers, normality of residuals, homoscedasticity of residuals, no multiearity, linear relationships)
* `15 Longitudinal analysis all phases output tables.do`
  * Outputs results into Excel tables (instead of copy+paste of tables from Stata)
* `16 Longitudinal analysis all phases bonferroni and ranking.do`
  * Calculate p-value after Bonferroni correction
  * Rank PBMs by mean change, standardised response mean (SRM), and standardised effect size (SES), and find the median rank
  * Annotate IRE results by whether a low or a high score indicates a positive or negative change
* `17 IEQ Descriptives.do`
  * Describe responses to IEQ (e.g. number and percentage providing each answer)
  * Describe demographics of IEQ samples

<br>

## 🏛️ Archived repository

To ensure persistence, this repository has been archived on Zenodo. It can be viewed at: https://doi.org/10.5281/zenodo.15095009.

<br>

## 📝 Citation

Please cite the archived repository on Zenodo:

> Goodwin, E., Heather, A., Green, C., Morrish, N., Freeman, J., Boddy, K., Thomas, S., Chataway, J., Middleton, R., & Hawton, A. (2025). HUMS Responsiveness. Zenodo. https://doi.org/10.5281/zenodo.15095009.

You can also cite this GitHub repository:

> Goodwin, E., Heather, A., Morrish, N., Freeman, J., Boddy, K., Thomas, S., Chataway, J., Middleton, R., & Hawton, A. (2025). HUMS Responsiveness. https://github.com/exeterhems/hums_responsiveness.

The author ORCID IDs for this publication are:

* [![ORCID: Goodwin](https://img.shields.io/badge/Elizabeth_Goodwin-0000--0003--1351--9170-brightgreen)](https://orcid.org/0000-0003-1351-9170)
* [![ORCID: Heather](https://img.shields.io/badge/Amy_Heather-0000--0002--6596--3479-brightgreen)](https://orcid.org/0000-0002-6596-3479)
* [![ORCID: Morrish](https://img.shields.io/badge/Nia_Morrish-0000--0002--7206--4957-brightgreen)](https://orcid.org/0000-0002-7206-4957)
* [![ORCID: Freeman](https://img.shields.io/badge/Jennifer_Freeman-0000--0002--4072--9758-brightgreen)](https://orcid.org/0000-0002-4072-9758)
* [![ORCID: Boddy](https://img.shields.io/badge/Kate_Boddy-0000--0001--9135--5488-brightgreen)](https://orcid.org/0000-0001-9135-5488)
* [![ORCID: Thomas](https://img.shields.io/badge/Sarah_Thomas-0000--0002--9501--9091-brightgreen)](https://orcid.org/0000-0002-9501-9091)
* [![ORCID: Chataway](https://img.shields.io/badge/Jeremy_Chataway-0000--0001--7286--6901-brightgreen)](https://orcid.org/0000-0001-7286-6901)
* [![ORCID: Middleton](https://img.shields.io/badge/Rod_Middleton-0000--0002--2130--4420-brightgreen)](https://orcid.org/0000-0002-2130-4420)
* [![ORCID: Hawton](https://img.shields.io/badge/Annie_Hawton-0000--0002--1336--5899-brightgreen)](https://orcid.org/0000-0002-1336-5899)

<br>

## 📜 Licence

This repository is licensed under an **MIT licence**.

<br>

## 💰 Acknowledgements

This work was supported by the UK MS Society (grant number 85).

This study makes use of anonymised data held by the UK Multiple Sclerosis Register funded by the MS Society and based on technology established by the SAIL databank. We would like to acknowledge all the data providers who make anonymised data available for research.

Obi Ukoumunne, Annie Hawton and Amy Heather were supported by the National Institute for Health and Care Research Applied Research Collaboration South West Peninsula. The views expressed are those of the authors and not necessarily those of the NHS, NIHR or the Department of Health and Social Care.