<h1 align="center">
  <br>
    <a href="https://medicine.exeter.ac.uk/health-community/research/healtheconomics/"><img src="https://raw.githubusercontent.com/amyheather/hums_responsiveness/main/images/exeter_economics.png" alt="Health Economics Group, University of Exeter"></a>
  <br>
  HUMS Responsiveness Paper
  <br>
</h1>

<p align="center">
    <a target="_blank" href="https://www.stata.com/"><img src="https://img.shields.io/badge/software-Stata-239120" alt="Software"/></a>
    <a href="#"><img src="https://img.shields.io/github/last-commit/amyheather/hums_responsiveness" alt="GitHub last commit" /></a>
    <a target="_blank" href="https://github.com/amyheather/hums_responsiveness/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT license"/></a>
</p>

<mark>TODO: Move to organisation (need to confirm if that would be alright, appropriate name, etc)</mark>

<mark>TODO: Add releases and DOI badges once/if created</mark>

<mark>TODO: Check what HUMS stood for, maybe add as tagline, as I've forgotten</mark>

This repository contains Stata do-files from the analysis performed for:

> **Comparative responsiveness of preference-based health-related quality of life, social care and wellbeing, condition-specific and generic measures in the context of multiple sclerosis**
> 
> Elizabeth Goodwin, Amy Heather, Colin Green, Nia Morrish, Jenny Freeman, Kate Boddy, Sarah Thomas, Jeremy Chataway, Rod Middleton, Annie Hawton

This is a draft paper currently being submit to journal/s to consider for publication. <mark>TODO: Add link to pre-print if allowed/decided to do one</mark>.

## Context

The provided do-files to analyse data from the **UK MS Register**. Analysis was performed in Stata <mark>TODO: add version if known</mark>, which is a paid software so a Stata license would be required to run these files.

Prior to analysis, the data underwent pre-processing including:

* <mark>TODO: check what steps were in prior do-files, or include them</mark>

After this pre-processing, the dataset format was <mark>TODO: describe the data e.g. patient-level, what sort of columns</mark>

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
  * Check regression assumptions (no outliers, normality of residuals, homoscedasticity of residuals, no multicolinearity, linear relationships)
* `15 Longitudinal analysis all phases output tables.do`
  * Outputs results into Excel tables (instead of copy+paste of tables from Stata)
* `16 Longitudinal analysis all phases bonferroni and ranking.do`
  * Calculate p-value after Bonferroni correction
  * Rank PBMs by mean change, standardised response mean (SRM), and standardised effect size (SES), and find the median rank
  * Annotate IRE results by whether a low or a high score indicates a positive or negative change
* `17 IEQ Descriptives.do`
  * Describe responses to IEQ (e.g. number and percentage providing each answer)
  * Describe demographics of IEQ samples

## 🏛️ Archived repository

To ensure persistence, this repository has been archived on Zenodo. It can be viewed at: <mark>TODO: Confirm if ok to archive and add link</mark>

## 📝 Citation

To cite this repository:

<!--TODO: Update with each new version-->
> Goodwin, E., Heather, A., Green, C., Morrish, N., Freeman, J., Boddy, K., Thomas, S., Chataway, J., Middleton, R., & Hawton, A. (2024). HUMS Responsiveness (Version v0.1.0) [Computer software]. https://github.com/amyheather/hums_responsiveness

The author ORCID IDs for this publication (where available) are:

<mark>TODO: Add any missing details to CITATION.cff and ORCID list. Need to ask Jenny, Sarah, and Jeremy if they have an ORCID.</mark>.

[![ORCID: Goodwin](https://img.shields.io/badge/Elizabeth_Goodwin-0000--0003--1351--9170-brightgreen)](https://orcid.org/0000-0003-1351-9170)
[![ORCID: Heather](https://img.shields.io/badge/Amy_Heather-0000--0002--6596--3479-brightgreen)](https://orcid.org/0000-0002-6596-3479)
[![ORCID: Green](https://img.shields.io/badge/Colin_Green-0000--0001--6140--1287-brightgreen)](https://orcid.org/0000-0001-6140-1287)
[![ORCID: Morrish](https://img.shields.io/badge/Nia_Morrish-0000--0002--7206--4957-brightgreen)](https://orcid.org/0000-0002-7206-4957)
[![ORCID: Boddy](https://img.shields.io/badge/Kate_Boddy-0000--0001--9135--5488-brightgreen)](https://orcid.org/0000-0001-9135-5488)
[![ORCID: Middleton](https://img.shields.io/badge/Rod_Middleton-0000--0002--2130--4420-brightgreen)](https://orcid.org/0000-0002-2130-4420)
[![ORCID: Hawton](https://img.shields.io/badge/Annie_Hawton-0000--0002--1336--5899-brightgreen)](https://orcid.org/0000-0002-1336-5899)

## 📜 License

This repository is licensed under an **MIT license**.

## 💰 Acknowledgements

<!--TODO: Confirm whether these are the correct funding and MSRegister acknowledgements statements-->

This work was supported by the UK MS Society (grant number 85).

This study makes use of anonymised data held by the UK Multiple Sclerosis Register funded by the MS Society and based on technology established by the SAIL databank. We would like to acknowledge all the data providers who make anonymised data available for research.

Obi Ukoumunne, Annie Hawton and Amy Heather were supported by the National Institute for Health and Care Research Applied Research Collaboration South West Peninsula. The views expressed are those of the authors and not necessarily those of the NHS, NIHR or the Department of Health and Social Care.
