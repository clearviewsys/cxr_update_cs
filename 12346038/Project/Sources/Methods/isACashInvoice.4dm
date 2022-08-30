//%attributes = {}

// isACashInvoice ($invoiceNumber)

C_TEXT:C284($1; $invoiceNumber)
C_BOOLEAN:C305($0; $isCash)

Case of 
	: (Count parameters:C259=1)
		$invoiceNumber:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=False:C215
$isCash:=False:C215

QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$invoiceNumber)

While (Not:C34(End selection:C36([Registers:10])))
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
	If ([Accounts:9]isCashAccount:3)
		$isCash:=True:C214
	End if 
	NEXT RECORD:C51([Registers:10])
End while 

$0:=$isCash





