//%attributes = {}
// isNewButtonDisabledForTable (->[table]) -> boolean
//Assign False if the table doesn't need to have an Entry form or those tables that are Transactional related where User cannot manually create a New Record in the Listbox

C_POINTER:C301($1; $tablePtr)
$tablePtr:=$1
Case of 
	: ($tablePtr=->[CashTransactions:36]) | ($tablePtr=->[ItemInOuts:40]) | ($tablePtr=->[CashInOuts:32]) | ($tablePtr=->[AccountInOuts:37]) | ($tablePtr=->[Sync_Queue:30])
		$0:=False:C215
		
	: ($tablePtr=->[Wires:8]) | ($tablePtr=->[Cheques:1]) | ($tablePtr=->[eWires:13]) | ($tablePtr=->[ShipmentLines:98]) | ($tablePtr=->[WebEWires:149])
		$0:=False:C215
		
	Else 
		$0:=True:C214
End case 