//%attributes = {}
// isCashTxOverThreshold ($invoiceNumber;$threshold)
// Validate if the Invoice is a cash tx and it is over the Threshold

C_TEXT:C284($1; $invoiceNumber)
C_REAL:C285($2; $threshold)
C_LONGINT:C283($i)
C_BOOLEAN:C305($0; $isCash; $isOverThreshold)

$isCash:=False:C215

$isOverThreshold:=False:C215
Case of 
	: (Count parameters:C259=2)
		$invoiceNumber:=$1
		$threshold:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_REAL:C285($tot)
$tot:=0

QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$invoiceNumber)

For ($i; 1; Records in selection:C76([Registers:10]))
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
	
	If ([Accounts:9]isCashAccount:3)
		$isCash:=True:C214
		
		If ([Registers:10]RegisterType:4="Buy")
			$tot:=$tot+[Registers:10]DebitLocal:23
		Else 
			$tot:=$tot+[Registers:10]CreditLocal:24
		End if 
		
	End if 
	
	NEXT RECORD:C51([Registers:10])
End for 

$0:=$isCash & ($tot>$threshold)
