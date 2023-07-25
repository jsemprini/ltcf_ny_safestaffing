****doubly robust analysis: comparing covid-19 outcomes in SNFs by "excessive profits" (y/n))***

clear all

use "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\b-LTC_covid_profits\revisions2\replicate\ltcf-safestaffing-replicate.dta"

cd "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\b-LTC_covid_profits\revisions2\replicate"

global count_outcomes residentstotaladmissionscovid19  residentstotalconfirmedcovid19 residentstotalcovid19deaths   residentstotalalldeaths    

global snf_cat sfs inhosp 

global snf_cont averagenumberofresidentsperday prop_full 


global snf_quality qmrating  reportedtotalnursestaffinghoursp reportedrnstaffinghoursperreside reportedlpnstaffinghoursperresid reportednurseaidestaffinghourspe reportedlicensedstaffinghoursper reportedphysicaltherapiststaffin

global county_controls county_cases county_deaths 


global county_code code*

estimates clear 


global reg_cont casemixtotalnursestaffinghourspe casemixrnstaffinghoursperresiden casemixlpnstaffinghoursperreside casemixnurseaidestaffinghoursper adjustedtotalnursestaffinghoursp adjustedrnstaffinghoursperreside adjustedlpnstaffinghoursperresid adjustednurseaidestaffinghourspe


foreach m in aipw {
	
foreach y in     residentstotaladmissionscovid19  residentstotalconfirmedcovid19 residentstotalcovid19deaths        resonly {

eststo: teffects `m' (`y' c.county_cases c.county_deaths i.($snf_cat)  c.($snf_cont $snf_quality) c.($reg_cont) , poisson ) (lawsuit i.nyc fp own1 i.($snf_cat)  c.( $snf_cont $snf_quality) , logit) [fweight = numberofallbeds], osample(newvar)


	
	drop newvar


}




estimates clear

}




foreach m in aipw {
	
foreach y in           residentstotalalldeaths      {

eststo: teffects `m' (`y'  i.($snf_cat)  c.($snf_cont $snf_quality) c.($reg_cont) , poisson ) (lawsuit i.nyc fp own1 i.($snf_cat)  c.( $snf_cont $snf_quality) , logit) [fweight = numberofallbeds], osample(newvar)

	
	drop newvar


}




estimates clear

}

****pom***


foreach m in aipw {
	
foreach y in     residentstotaladmissionscovid19  residentstotalconfirmedcovid19 residentstotalcovid19deaths        resonly {

eststo: teffects `m' (`y' c.county_cases c.county_deaths i.($snf_cat)  c.($snf_cont $snf_quality) c.($reg_cont) , poisson ) (lawsuit i.nyc fp own1 i.($snf_cat)  c.( $snf_cont $snf_quality) , logit) [fweight = numberofallbeds], osample(newvar) pom


	drop newvar


}




estimates clear

}




foreach m in aipw {
	
foreach y in           residentstotalalldeaths      {

eststo: teffects `m' (`y'  i.($snf_cat)  c.($snf_cont $snf_quality) c.($reg_cont) , poisson ) (lawsuit i.nyc fp own1 i.($snf_cat)  c.( $snf_cont $snf_quality) , logit) [fweight = numberofallbeds], osample(newvar) pom


	
	drop newvar


}




estimates clear

}





