//%attributes = {}
C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($page; $2)
$tablePtr:=$1
$page:=$2

If (isUserAuthorizedToPrint($tablePtr))
	//PRINT SETTINGS
	//OUTPUT FORM($tablePtr->;$page)
	//PRINT RECORD($tablePtr->)
	//Print form($tablePtr->;$page)
	printRecordUsingPrinter($tablePtr; $page; getClientDefaultPrinterName; 0)
Else 
	myAlert("You are not authorized to print this page.")
End if 