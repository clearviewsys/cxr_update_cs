//%attributes = {}
// getClientCopiesPerInvoice({ClientName}) -> copies
// get number of extra copies to be printed for each invoice

C_LONGINT:C283($0)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	$0:=[ClientPrefs:26]copiesPerInvoice:6
Else 
	$0:=0
End if 