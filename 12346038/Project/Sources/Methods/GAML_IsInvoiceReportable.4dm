//%attributes = {}
// GAM_IsInvoiceReportable ($invoiceNumber;$refDate;$exported)

C_TEXT:C284($1; $invoiceNumber)
C_DATE:C307($2; $refDate)
C_BOOLEAN:C305($3; $exported)
C_REAL:C285($totMarketRate)

C_BOOLEAN:C305($0; $reportable)

Case of 
	: (Count parameters:C259=3)
		$invoiceNumber:=$1
		$refDate:=$2
		$exported:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_BOOLEAN:C305($reportable)
C_REAL:C285($tot)

QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$invoiceNumber)

QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)

$tot:=0
$reportable:=False:C215

While (Not:C34(End selection:C36([Registers:10])))
	
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
	// Only Cash transactions
	If ([Accounts:9]isCashAccount:3)
		
		If ([Registers:10]RegisterType:4="Buy")
			$tot:=$tot+[Registers:10]DebitLocal:23
		Else 
			$tot:=$tot+[Registers:10]CreditLocal:24
		End if 
		
	End if 
	
	
	NEXT RECORD:C51([Registers:10])
	
End while 

If ($tot><>twoIDsLimit)
	If (isCustomerReportable([Invoices:5]CustomerID:2))
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 


