//%attributes = {}
// getHighRiskOccupationCodes
// returns a collection of high risk occupation codes
// see also : initStorageObject

#DECLARE()->$occupations : Collection

/*
[Occupations]Occupation
[Occupations]Code
[Occupations]Category
[Occupations]AML_Risk
*/

$occupations:=ds:C1482.Occupations.query("AML_Risk >= 4").distinct("Code")