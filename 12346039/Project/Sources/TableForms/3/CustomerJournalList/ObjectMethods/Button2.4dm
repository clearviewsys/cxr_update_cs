C_TEXT:C284($message)
C_LONGINT:C283($i; $n)

checkInit
//checkAddWarning ("Please verify )

If (isValidationConfirmed)
	C_REAL:C285($turnover)
	$turnover:=Sum:C1([Registers:10]DebitLocal:23)
	$message:=$message+"Customer ID:"+[Invoices:5]CustomerID:2+CRLF
	$message:=$message+[Customers:3]FullName:40+CRLF
	$message:=$message+"Turnover: "+String:C10($turnover)+" "+<>baseCurrency+CRLF
	$message:=$message+"Active within "+String:C10(<>checkNPreviousDays+1)+" days"+CRLF
	
	
	createRecordExceptionLog(->[Invoices:5]; "Repeat Transaction"; vInvoiceNumber; $message)
	
End if 

