//%attributes = {}
If ($1=<>baseCurrency)
	createAccount(makeChequeAccountID($1); c_Cash; $1; True:C214; False:C215)  // cheque received-CAD goes under cash (current asset)
Else 
	createAccount(makeChequeAccountID($1); c_ForeignCurrencies; $1; True:C214; False:C215)  // cheque received-FC goes under foreign currencies
End if 
