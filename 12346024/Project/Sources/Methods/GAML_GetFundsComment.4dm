//%attributes = {}
// GAML_GetFundsComment
// Gets the Funds Coment using the invoice number


C_TEXT:C284($0)

//C_TEXT($1;$invoiceNumber)

Case of 
		
	: (Count parameters:C259=0)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$0:=[Invoices:5]SourceOfFund:68


