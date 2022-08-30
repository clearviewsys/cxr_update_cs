//%attributes = {}
C_REAL:C285(vTotalAmount; vRemaining)
//If (Abs(vTotalAmount-[CashTransactions]Amount)>◊CashFaultTolerance)  ` the difference is beyond the acceptable fault tolerance for cash transactions
//checkAddError ("The sum of entries "+String(vTotalAmount;"|Currency")+" must be reasonably close to the original amount "+String([CashTransactions]Amount;"|Currency"))
//End if 


If (vTotalAmount>0)
	If (Abs:C99(vTotalAmount-[CashTransactions:36]Amount:3)>=1)  // the difference is beyond the acceptable fault tolerance for cash transactions
		checkAddError("The denominations entered "+String:C10(vTotalAmount)+"do not match the total amount.")
	End if 
End if 


If ([CashTransactions:36]isPaid:2)  // cash is sold
	checkAddErrorIf(((vRemaining>1) & ([Currencies:6]doRequestDenoms:53=True:C214) & ([CashTransactions:36]Amount:3>[Currencies:6]RequestDenomOnPayGT:52)); "Denomination entries don't match the payment amount.")
	
	If (vBalanceAfter<0)
		C_TEXT:C284($msg)
		$msg:="We don't carry sufficient "+[CashTransactions:36]CashAccountID:9+" on hand."
		checkAddErrorOnTrue([Currencies:6]doPreventShortSelling:54; $msg)
	End if 
Else   // cash is bought
	checkAddErrorIf(((vRemaining>1) & ([Currencies:6]doRequestDenoms:53=True:C214) & ([CashTransactions:36]Amount:3>[Currencies:6]RequestDenomOnReceiveGT:51)); "Denomination entries don't match the receiving amount.")
	
End if 

checkGreaterThan(->[CashTransactions:36]Amount:3; "Total Amount"; 0)
checkifRecordExists(->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; ->[CashTransactions:36]Currency:4; "Currency")
checkifRecordExists(->[CashAccounts:34]; ->[CashAccounts:34]AccountID:1; ->[CashTransactions:36]CashAccountID:9; "Cash Account")
checkifAccountisOfCurrency([CashTransactions:36]CashAccountID:9; [Currencies:6]ISO4217:31)
