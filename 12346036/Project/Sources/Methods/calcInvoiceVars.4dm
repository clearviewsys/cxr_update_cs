//%attributes = {}
// calcInvoiceVars (->vFromAmount;->vToAmount;->vFromBalance;->vToBalance)
// PRE: REGISTERS must be selected, invoice must be loaded

C_POINTER:C301($1; $2; $3; $4)
C_REAL:C285($vTotalReceived; $vTotalPaid; $vFromAmount; $vToAmount; $vFromBalance; $vtoBalance)

If (([Invoices:5]fromAmount:25=0) & ([Invoices:5]toAmount:26=0))
	$1->:=0
	$2->:=0
	$3->:=0
	$4->:=0
Else 
	
	$vTotalReceived:=Sum:C1([Registers:10]Debit:8)
	$vTotalPaid:=Sum:C1([Registers:10]Credit:7)
	
	Case of 
		: (getInvoiceTransactionTypeEnum([Invoices:5]TransactionType:12)=1)  // BUY
			$vFromAmount:=[Invoices:5]CurrencyBought:4
			$vToAmount:=[Invoices:5]AmountPaidCAD:7
			
			
		: (getInvoiceTransactionTypeEnum([Invoices:5]TransactionType:12)=2)  // SELL
			$vFromAmount:=[Invoices:5]AmountReceivedCAD:9
			$vToAmount:=[Invoices:5]TotalCurrencySold:11
			
			
		: (getInvoiceTransactionTypeEnum([Invoices:5]TransactionType:12)=3)  // CROSS
			$vFromAmount:=[Invoices:5]CurrencyBought:4
			$vToAmount:=[Invoices:5]TotalCurrencySold:11
			
		: (getInvoiceTransactionTypeEnum([Invoices:5]TransactionType:12)=4)  // Charge
			$vFromAmount:=[Invoices:5]AmountReceivedCAD:9
			$vToAmount:=[Invoices:5]AmountPaidCAD:7
	End case 
	// calculate the remaing balance
	$vFromBalance:=$vFromAmount-$vTotalReceived
	$vtoBalance:=$vToAmount-$vTotalPaid
	$1->:=$vFromAmount
	$2->:=$vToAmount
	$3->:=$vFromBalance
	$4->:=$vToBalance
End if 