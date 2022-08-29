//%attributes = {}
// FT_SumUsingMarketRate ($invoiceNumber)

C_TEXT:C284($1; $invoiceNumber)
C_REAL:C285($0; $totMarketRate)
C_BOOLEAN:C305($exported)

Case of 
	: (Count parameters:C259=1)
		$invoiceNumber:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$exported:=(operationMode=0)
QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$invoiceNumber)

//QUERY SELECTION([Registers]; & ;[Registers]Debit>0;*)
//QUERY SELECTION([Registers]; & ;[Registers]isCash=True;*)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)
//QUERY SELECTION([Registers]; & ;[Registers]isExported=$exported)

$totMarketRate:=0

While (Not:C34(End selection:C36([Registers:10])))
	
	
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
	
	If (([Accounts:9]isCashAccount:3) & ([Registers:10]Debit:8>0))
		
		If ([Registers:10]RegisterType:4="Buy")
			$totMarketRate:=$totMarketRate+AmountToSpotRate([Registers:10]DebitLocal:23)
		Else 
			$totMarketRate:=$totMarketRate+AmountToSpotRate([Registers:10]CreditLocal:24)
		End if 
		
		
	End if 
	
	
	NEXT RECORD:C51([Registers:10])
End while 

$0:=$totMarketRate