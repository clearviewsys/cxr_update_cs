//%attributes = {}
#DECLARE()->$pots : Collection
// getHighRiskPOTs
// returns a collection of high risk Purpose of Transactions (including code; and purpose)
// see also: initStorageObject

//[List_POT]Purpose
$pots:=ds:C1482.List_POT.query("isHighRisk == true").distinct("Purpose")
