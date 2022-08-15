If (Form event code:C388=On Load:K2:1)
	
	ARRAY TEXT:C222(arrInvoices; 0)
	ARRAY REAL:C219(arrDebits; 0)
	ARRAY REAL:C219(arrCredits; 0)
	ARRAY TEXT:C222(arrCurrencies; 0)
	ARRAY REAL:C219(arrDebitLocals; 0)
	ARRAY REAL:C219(arrCreditLocals; 0)
	ARRAY REAL:C219(arrRunningBalances; 0)
	ARRAY REAL:C219(arrLocalFees; 0)
	ARRAY REAL:C219(arrOurRates; 0)
	ARRAY DATE:C224(arrDates; 0)
	ARRAY TEXT:C222(arrComments; 0)
	
	SELECTION TO ARRAY:C260([Registers:10]InvoiceNumber:10; arrInvoices; [Registers:10]RegisterDate:2; arrDates; [Registers:10]Debit:8; arrDebits; [Registers:10]Credit:7; arrCredits; [Registers:10]Currency:19; arrCurrencies; [Registers:10]DebitLocal:23; arrDebitLocals; [Registers:10]CreditLocal:24; arrCreditLocals; [Registers:10]feeLocal:29; arrLocalFees; [Registers:10]OurRate:25; arrOurRates; [Registers:10]Credit:7; arrRunningBalances; [Registers:10]Comments:9; arrComments)
	
	fillRunningBalanceArray(->arrDebitLocals; ->arrCreditLocals; ->arrRunningBalances)
	
End if 

If ((Form event code:C388=On Row Moved:K2:32) | (Form event code:C388=On After Sort:K2:28))
	fillRunningBalanceArray(->arrDebitLocals; ->arrCreditLocals; ->arrRunningBalances)
End if 