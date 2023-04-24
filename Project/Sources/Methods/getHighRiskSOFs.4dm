//%attributes = {}
#DECLARE()->$sof : Collection
// getHighRiskSOFs
// returns a collection of high risk Source of Funds (Source)

//[List_SOF]Source
$sof:=ds:C1482.List_SOF.query("isHighRisk == true").distinct("Source")