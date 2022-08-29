//%attributes = {}
CONFIRM:C162(vFullComments; "Confirm"; "Cancel")
If (OK=1)
	
	START TRANSACTION:C239
	
	TM_Add2Stack(->[Registers:10]; Current method name:C684; Transaction level:C961)
	
	C_TEXT:C284($transferID)
	$transferID:="Tr-"+makeRegisterID
	
	CREATE RECORD:C68([Registers:10])  // Withdraw from Account
	[Registers:10]AccountID:6:=vFromAccount
	[Registers:10]RegisterType:4:="Transfer"
	[Registers:10]RegisterDate:2:=vTransferDate
	[Registers:10]CustomerID:5:="self"  // means us
	[Registers:10]InvoiceNumber:10:=$transferID
	[Registers:10]Credit:7:=vFromAmount
	[Registers:10]isReceived:13:=False:C215
	[Registers:10]Comments:9:=vFullComments
	[Registers:10]Currency:19:=vFromCurrency
	SAVE RECORD:C53([Registers:10])
	
	CREATE RECORD:C68([Registers:10])  // deposit into Account
	[Registers:10]AccountID:6:=vToAccount
	[Registers:10]RegisterType:4:="Transfer"
	[Registers:10]RegisterDate:2:=vTransferDate
	[Registers:10]CustomerID:5:="self"  // means us
	[Registers:10]Debit:8:=vToAmount
	[Registers:10]isReceived:13:=True:C214
	[Registers:10]Comments:9:=vFullComments
	[Registers:10]InvoiceNumber:10:=$transferID
	[Registers:10]Currency:19:=vToCurrency
	SAVE RECORD:C53([Registers:10])
	UNLOAD RECORD:C212([Registers:10])  // unlock the record for modification
	
	VALIDATE TRANSACTION:C240
	
	TM_RemoveFromStack
	
Else 
	REJECT:C38
End if 
