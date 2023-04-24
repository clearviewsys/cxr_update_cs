//%attributes = {}
// agg_runAMLRulesOnTodaysInvoices
// this method can be called from a Calendar Event


var $dateRange : Object
$dateRange:=newDateRange(Current date:C33; Current date:C33)

agg_applyRulesToInvoices($dateRange; True:C214)