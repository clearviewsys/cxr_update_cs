//%attributes = {}
// print2LevelBreakTable($mainTablePtr;$inTablePtr;$sortKey1Ptr;$sortKey2Ptr;$realFieldPtr)

C_POINTER:C301($1; $2; $3; $4; $5)
C_POINTER:C301($inTablePtr; $mainTablePtr; $sortKey1Ptr; $sortKey2Ptr; $realFieldPtr; $realFieldPtr2)
C_TEXT:C284($7; $formName)

$mainTablePtr:=$1
$inTablePtr:=$2
$sortKey1Ptr:=$3
$sortKey2Ptr:=$4
$realFieldPtr:=$5
$realFieldPtr2:=$6

If (Records in selection:C76($mainTablePtr->)>0)
	C_TEXT:C284($setName)
	$setName:=Table name:C256($mainTablePtr)+"pSet"
	
	CREATE SET:C116($mainTablePtr->; $setName)
	//ORDER BY($mainTablePtr->;$mainTablePtr->BankShortName)
	RELATE MANY SELECTION:C340($sortKey1Ptr->)  // select all the branches connected to the selection of banks
	ORDER BY:C49($inTablePtr->; $sortKey1Ptr->; >; $sortKey2Ptr->; >)
	
	BREAK LEVEL:C302(2)  // BREAK LEVEL AND ACCUMULATE MUST BE TOGETHER FOR BREAK PROCESSING
	If (Count parameters:C259=5)
		ACCUMULATE:C303($realFieldPtr->)
	Else 
		ACCUMULATE:C303($realFieldPtr->; $realFieldPtr2->)
	End if 
	If (Count parameters:C259=7)
		$formName:=$7
	Else 
		$formName:="print"+Table name:C256($mainTablePtr)
	End if 
	//OUTPUT FORM($inTablePtr->;$formName)
	//
	//If (◊DisplayPageSetup=True)
	//PRINT SELECTION($inTablePtr->)
	//Else 
	//PRINT SELECTION($inTablePtr->;*)  ` omits the print setup dialog
	//End if 
	printSelectionUsingPrinter($inTablePtr; $formName; getClientDefaultPrinterName; 0)
	
	USE SET:C118($setName)
	CLEAR SET:C117($setName)
Else 
	myAlert("No Records is Selected.")
End if 