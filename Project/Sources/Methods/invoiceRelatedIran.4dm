//%attributes = {}


C_TEXT:C284($1; $invoiceNumber)
C_DATE:C307($2; $refDate)
C_BOOLEAN:C305($0; $isEFTI)

C_BOOLEAN:C305($isCash; $isIranRelated)
$isEFTI:=False:C215

Case of 
	: (Count parameters:C259=2)
		$invoiceNumber:=$1
		$refDate:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=False:C215
$isCash:=False:C215
$isIranRelated:=False:C215

If ([Invoices:5]invoiceDate:44=$refDate)
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$invoiceNumber)
	
	While (Not:C34(End selection:C36([Registers:10])))
		
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
		
		If (([Accounts:9]isCashAccount:3) & ([Registers:10]InternalTableNumber:17#37) & ([Registers:10]Debit:8>0))  // 37 - Table AccountInOuts
			$isCash:=True:C214
		End if 
		
		If (([Registers:10]Currency:19="TOM") | ([Registers:10]Currency:19="IRR"))
			$isIranRelated:=True:C214
		End if 
		
		
		If ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
			READ ONLY:C145([eWires:13])
			QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)
			If ([eWires:13]isPaymentSent:20=False:C215)
				$isEFTI:=True:C214
			End if 
			
		End if 
		
		
		NEXT RECORD:C51([Registers:10])
		
		
	End while 
	
	
End if 

If ($isEFTI)
	$isIranRelated:=False:C215
End if 

$0:=$isCash & $isIranRelated




