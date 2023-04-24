//%attributes = {}
// PickAMLRuleID (SearchString)
// #ORDA

C_TEXT:C284($searchString)

If (Count parameters:C259>=1)
	C_TEXT:C284($1)
	$searchString:=$1
Else 
	$searchString:=""
End if 

// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[AML_AggrRules:150]ruleID:53; 150; "Rule ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[AML_AggrRules:150]ruleName:2; 200; "Rule Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[AML_AggrRules:150]description:3; 250; "Description")
$listboxcolumns.push($listboxcolumn)

C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="AML Aggr Rule"
$parameters.preQueryStr:=$searchString
$parameters.preQueryStr:="ruleID = "+$searchString+"@"

// do not make selection in table, we will use just the entity selection
//$parameters.makeSelection:=False

C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
//LOAD RECORD([AML_AggrRules])