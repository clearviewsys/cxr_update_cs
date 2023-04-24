//%attributes = {}
// printFormsTable( ->table;->breakField; formName;$methodNameForPrintingDetail; {reportTitle;{hasHeader;{hasBreak;{hasFooter;{doPageBreak}}}}})
// This is a very powerful method that uses the PRINT FORM command to manually handle advanced printing options
//

C_POINTER:C301($1; $2; $tableptr; $fieldPtr)
C_TEXT:C284($3; $4; $5; $formName; $reportTitle; $methodName)
C_BOOLEAN:C305($6; $7; $8; $9; $hasHeader; $hasBreak; $hasFooter; $doPageBreak)
C_TEXT:C284($onPrintingBreakMethod; $10)

$tablePtr:=$1
$fieldPtr:=$2
$formName:=$3
$methodName:=$4
$reportTitle:=""
$hasHeader:=False:C215
$hasBreak:=False:C215
$hasFooter:=False:C215
$doPageBreak:=True:C214
$onPrintingBreakMethod:=""
Case of 
	: (Count parameters:C259=5)
		$reportTitle:=$5
	: (Count parameters:C259=6)
		$reportTitle:=$5
		$hasHeader:=$6
	: (Count parameters:C259=7)
		$reportTitle:=$5
		$hasHeader:=$6
		$hasBreak:=$7
	: (Count parameters:C259=8)
		$reportTitle:=$5
		$hasHeader:=$6
		$hasBreak:=$7
		$hasFooter:=$8
	: (Count parameters:C259=9)
		$reportTitle:=$5
		$hasHeader:=$6
		$hasBreak:=$7
		$hasFooter:=$8
		$doPageBreak:=$9
		
	: (Count parameters:C259=10)
		$reportTitle:=$5
		$hasHeader:=$6
		$hasBreak:=$7
		$hasFooter:=$8
		$doPageBreak:=$9
		$onPrintingBreakMethod:=$10
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_POINTER:C301($tablePtr)
C_TEXT:C284($formName; vPageNumber)

C_LONGINT:C283(vRowNumber; $n)

If ($reportTitle#"")
	printFormHeader($reportTitle)
End if 

If ($hasHeader)
	Print form:C5($tablePtr->; $formName; Form header:K43:3)
End if 

READ ONLY:C145($tablePtr->)
FIRST RECORD:C50($tablePtr->)
$n:=Records in selection:C76($tablePtr->)
C_BOOLEAN:C305($break)
$break:=isTextChanged($fieldPtr->; True:C214)

C_LONGINT:C283(vRowPerBreak)
vRowPerBreak:=1
For (vRowNumber; 1; $n)
	//vPageNumber:="Page "+String(vRowNumber\$linePerSection+1)+"/"+String($n\$linePerSection+1)
	
	LOAD RECORD:C52($tablePtr->)
	executeMethodName($methodName)
	
	Print form:C5($tablePtr->; $formName; Form detail:K43:1)  // Use one form for the details 
	NEXT RECORD:C51($tablePtr->)
	
	If ((isTextChanged($fieldPtr->; False:C215)) & ($hasBreak))  // print the break if form has break processing
		Print form:C5($tablePtr->; $formName; Form break0:K43:14)  // print break
		If ($onPrintingBreakMethod#"")
			executeMethodName($onPrintingBreakMethod)
		End if 
		
		If (vRowNumber#$n)  // print another header if it's not the end of records
			Print form:C5($tablePtr->; $formName; Form header:K43:3)  // Use one form for the details 
		End if 
	End if 
	vRowPerBreak:=vRowPerBreak+1
End for 

If ($hasFooter)
	Print form:C5($tablePtr->; $formName; Form footer:K43:2)  // Use footer for the sum
End if 

If ($doPageBreak)
	PAGE BREAK:C6  // Make sure the last page is printed
End if 
