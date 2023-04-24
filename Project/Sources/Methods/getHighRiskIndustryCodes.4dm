//%attributes = {}
// getHighRiskIndustries
// returns a collection of high risk industry codes
// see also : initStorageObject

#DECLARE()->$highRiskIndustryCodes : Collection

//[Industries]AML_Risk
//[Industries]Code

$highRiskIndustryCodes:=ds:C1482.Industries.query("AML_Risk >= 4").distinct("Code")