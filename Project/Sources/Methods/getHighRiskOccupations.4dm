//%attributes = {}
// getHighRiskOccupations
// returns a collection of high risk occupations
// see also : initStorageObject
//MARK: we may need to rething this method and return occupation codes instead

#DECLARE()->$occupations : Collection

/*
[Occupations]Occupation
[Occupations]Code
[Occupations]Category
[Occupations]AML_Risk
*/

$occupations:=ds:C1482.Occupations.query("AML_Risk >= 4").distinct("Occupation")