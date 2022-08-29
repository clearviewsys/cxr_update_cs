//%attributes = {}
// getClientCopiesPerCheque({ClientName}) -> copies
// get number of extra copies to be printed for each Cheque

C_LONGINT:C283($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]copiesPerCheque:7
Else 
	$0:=0
End if 