//%attributes = {}
//printTable (->[Items];"list";->[Items]ItemCategory;->[Items]ItemID)


C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_TEXT:C284($formName; $methodName; $reportName)
C_POINTER:C301($tablePtr; $dateFieldPtr; $breakFieldPtr; $manyTablePtr; $manyTableDatePtr; $manyTableID; $manyTableIDPtr)

$tablePtr:=->[Items:39]
$manyTablePtr:=->[ItemInOuts:40]
$manyTableDatePtr:=->[ItemInOuts:40]Date:3
$manyTableIDPtr:=->[ItemInOuts:40]ItemID:2

$breakFieldPtr:=->[Items:39]Category:3
$formName:="list"
$methodName:="calcItemsRepLineVars"
$reportName:="Items Report"


vFromDate:=Current date:C33
vToDate:=Current date:C33

requestDateRangeTable($manyTablePtr; $manyTableDatePtr)
If (OK=1)
	ORDER BY:C49($manyTablePtr->; $manyTableDatePtr->; >; $manyTableIDPtr->; >)
	RELATE ONE SELECTION:C349($manyTablePtr->; $tablePtr->)  // 
	
	printSettings
	If (OK=1)
		ORDER BY:C49($tablePtr->; $breakFieldPtr->; >)
		//printFormsTable( ->table;->breakField; formName;$methodNameForPrintingDetail; {reportTitle;{hasHeader;{hasBreak;{hasFooter;{doPageBreak}}}}})
		printFormsTable($tablePtr; $breakFieldPtr; $formName; $methodName; $reportName; True:C214; True:C214; True:C214; True:C214)
	End if 
End if 
