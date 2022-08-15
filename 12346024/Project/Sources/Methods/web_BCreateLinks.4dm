//%attributes = {"publishedWeb":true}
C_REAL:C285(webFromAmountR; webToAmountR)
C_TEXT:C284(webFromAmount; webToAmount)
C_TEXT:C284(webFromName; webToName; webFromCurrency; webToCurrency)
C_TEXT:C284(webFirstName; webLastName; webCustomerName; webCity; webUnconfirmedCustomerName)

web_ValidateLinks


If (checkErrorExist)
	//vErrorString:=checkGetErrorString 
	web_SendERRORPage($1)
Else 
	web_BCreate(->[Links:17])
	web_SendUserAreaPage
End if 