//%attributes = {}
//printTable(->table; formName: ->fieldOrder1;->fieldOrder2;->fieldOrder3;->fieldOrder4)
C_TEXT:C284($2; $formName)
C_POINTER:C301($1; $3; $4; $5; $6; $7)
C_BOOLEAN:C305(<>DisplayPageSetup)
$formName:=$2
Case of 
	: (Count parameters:C259=3)
		ORDER BY:C49($1->; $3->; >)
	: (Count parameters:C259=4)
		ORDER BY:C49($1->; $3->; >; $4->; >)
	: (Count parameters:C259=5)
		ORDER BY:C49($1->; $3->; >; $4->; >; $5->; >)
	: (Count parameters:C259=6)
		ORDER BY:C49($1->; $3->; >; $4->; >; $5->; >; $6->; >)
	: (Count parameters:C259=7)
		ORDER BY:C49($1->; $3->; >; $4->; >; $5->; >; $6->; >; $7->; >)
End case 

If (Records in selection:C76($1->)>0)
	
	//OUTPUT FORM($1->;$formName)
	//If (◊DisplayPageSetup=True)
	//PRINT SELECTION($1->)
	//Else 
	//PRINT SELECTION($1->;*)
	//End if 
	printSelectionUsingPrinter($1; $formName; getClientDefaultPrinterName; 0)
	
Else 
	myAlert("No Records is Selected.")
End if 
