//%attributes = {}
C_LONGINT:C283($win)
C_OBJECT:C1216($es)
//getBuild
$es:=New object:C1471
$es.stats:=New object:C1471  // this attribute will display all the stats of customers
$es.rules:=ds:C1482.AML_AggrRules.all().orderBy("rowNo")
//$es.Rule:=newAML_AggrRule   // this line doesn't work; somehow the binding of the listbox prevents this
//[AML_AggrRules]rowNo

// [AML_AggrRules]
// [AML_AggrRules];"entry"
// [AML_AggrRules];"Match"
// validateInvoice_AMLRulesPro
// validateInvoice_AML_AggrRules
// This_RuleColour 
// thenApplyRuleActions

$win:=Open form window:C675([AML_AggrRules:150]; "Match")
DIALOG:C40([AML_AggrRules:150]; "Match"; $es)
//validateAML_AggrRules
//createEwireFromWebeWire