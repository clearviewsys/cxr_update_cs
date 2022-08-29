//%attributes = {}
// FJ_CalculateTotals

C_OBJECT:C1216($0; $invoiceTotals)
C_TEXT:C284($1; $invoiceNum)

Case of 
	: (Count parameters:C259=1)
		$invoiceNum:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_OBJECT:C1216($registers; $reg; $cheques; $cheque; $ewires; $ewire; $accounts; $account; $cashTransactions)

$invoiceTotals:=New object:C1471

$invoiceTotals.totCash:=0
$invoiceTotals.totalBankDrafs:=0
$invoiceTotals.totalBankCheques:=0

$invoiceTotals.totReceived:=0
$invoiceTotals.totCashPayIn:=0
$invoiceTotals.totCashPayOut:=0


//If ($invoiceNum="FHINV57887")
//TRACE
//End if 

$registers:=ds:C1482.Registers.query("InvoiceNumber = :1"; $invoiceNum)

For each ($reg; $registers)
	
	
	Case of 
			
		: ($reg.InternalTableNumber=Table:C252(->[eWires:13]))
			
			$ewires:=ds:C1482.eWires.query("eWireID = :1"; $reg.InternalRecordID)
			For each ($ewire; $ewires)
				$invoiceTotals.totalBankDrafs:=$invoiceTotals.totalBankDrafs+$ewire.amountLocal-$reg.totalFees
			End for each 
			
			// DONE
		: ($reg.InternalTableNumber=Table:C252(->[Cheques:1]))
			$cheques:=ds:C1482.Cheques.query("ChequeID = :1"; $reg.InternalRecordID)
			For each ($cheque; $cheques)
				$invoiceTotals.totalBankCheques:=$invoiceTotals.totalBankCheques+$cheque.amountLocal
			End for each 
			
		: ($reg.InternalTableNumber=Table:C252(->[Accounts:9]))
			
			$accounts:=ds:C1482.Accounts.query("AccountID = :1"; $reg.InternalRecordID)
			For each ($account; $accounts)
				
				If ($reg.DebitLocal>0)
					$invoiceTotals.totReceived:=$invoiceTotals.totCash+$reg.DebitLocal
					$invoiceTotals.totCashPayIn:=$invoiceTotals.totCashPayIn+$reg.DebitLocal
				End if 
				
				If ($reg.CreditLocal>0)
					$invoiceTotals.totReceived:=$invoiceTotals.totCash+$reg.CreditLocal
					$invoiceTotals.totCashPayOut:=$invoiceTotals.totCashPayOut+$reg.CreditLocal
				End if 
				
			End for each 
			
			
			
		: ($reg.InternalTableNumber=Table:C252(->[AccountInOuts:37]))
			
			//[AccountInOuts]AccountID
			$accounts:=ds:C1482.AccountInOuts.query("AccountInOutID = :1"; $reg.InternalRecordID)
			
			For each ($account; $accounts)
				
				If ($reg.DebitLocal>0)
					$invoiceTotals.totReceived:=$invoiceTotals.totCash+$reg.DebitLocal
					$invoiceTotals.totCashPayIn:=$invoiceTotals.totCashPayIn+$reg.DebitLocal
				End if 
				
				If ($reg.CreditLocal>0)
					$invoiceTotals.totReceived:=$invoiceTotals.totCash+$reg.CreditLocal
					$invoiceTotals.totCashPayOut:=$invoiceTotals.totCashPayOut+$reg.CreditLocal
				End if 
				
			End for each 
			
			//: ($reg.InternalTableNumber=Table(->[CashTransactions]))
			
			
			//$cashTransactions:=ds.CashTransactions.query("CashTransactionID = :1";$reg.InternalRecordID)
			////[CashTransactions]
			
			
			//For each ($cashtx;$cashTransactions)
			
			//If ($reg.RegisterType="Buy")
			//$invoiceTotals.totReceived:=$invoiceTotals.totReceived+$cashtx.amountLocal
			//Else 
			//$invoiceTotals.totCashPayOut:=$invoiceTotals.totCashPayOut+$cashtx.amountLocal
			//End if 
			//End for each 
			
			
			
			
		Else 
			//$aa:=$reg.InternalTableNumber
			
			//$accounts:=ds.AccountInOuts.query("AccountInOutID = :1";$reg.InternalRecordID)
			//If ($reg.RegisterType="Buy")
			//$invoiceTotals.totReceived:=$invoiceTotals.totReceived+$reg.DebitLocal
			//Else 
			//$invoiceTotals.totCashPayOut:=$invoiceTotals.totCashPayOut+$reg.CreditLocal
			//End if 
			
			
	End case 
	
End for each 

$0:=$invoiceTotals

