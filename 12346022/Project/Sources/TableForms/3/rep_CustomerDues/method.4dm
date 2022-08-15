//  ` handleTabCustomerRecPay( c_Receivables/c_Payables)
//
//  ` first find all accounts that are receivale and payable
//$fe:=Form event
//
//If (($fe=On Display Detail ) | ($fe=On Printing Detail ))
//
//  ` first find all accounts that are receivale and payable
//QUERY([Accounts];[Accounts]MainAccountID=c_Receivables ;*)
//QUERY([Accounts]; | ;[Accounts]MainAccountID=c_Payables )
//
//RELATE MANY SELECTION([Registers]AccountID)
//
//  ` filter this customer only (we need the receivables for this customer only)
//QUERY SELECTION([Registers];[Registers]CustomerID=[Customers]CustomerID)
//orderByRegisters 
//C_REAL(vSumDebitsLocal;vSumCreditsLocal;vBalanceLocal)
//getRegisterSums (->vSumDebitsLocal;->vSumCreditsLocal;->vBalanceLocal)
//
//End if 
