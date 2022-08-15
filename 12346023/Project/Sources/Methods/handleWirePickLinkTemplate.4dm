//%attributes = {}

C_TEXT:C284($oldAccountID; vBankAccountID)
$oldAccountID:=vBankAccountID
vBankAccountID:=""

pickLinkForCustomer(->vBankAccountID; [Customers:3]CustomerID:1)
If (OK=1)
	mapLinkToWire
Else 
	vBankAccountID:=$oldAccountID  // restore the old value
End if 

