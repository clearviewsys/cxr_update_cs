//%attributes = {"publishedWeb":true}
C_TEXT:C284(webFromAmount; webForeignAccount; webDoTransferToAccount; webDoDeliverToAddress)
C_TEXT:C284(webToCurrency; webFromCurrency)
C_REAL:C285(webFromAmountR; webToAmountR)
C_TEXT:C284(webFromAmount; webToAmount)
C_TEXT:C284(webLinkID; webFromName; webToName; webFromCurrency; webToCurrency)
C_TEXT:C284(webRate; webInverseRate; webChannelConfirmationNo)

checkInit
checkIfNullString(->webFromAmount; "From Amount")  // for mandatory strings
If ((webDoTransferToAccount#"") & (webDoDeliverToAddress#""))  // canot be both checked
	checkAddError("You have to choose either 'transfer to...' or 'Deliver to...' but not both.")
End if 
QUERY:C277([Links:17]; [Links:17]LinkID:1=webLinkID)
If (Records in selection:C76([Links:17])#1)
	checkAddError("The Link ID is not valid. Please enter a valid Link ID")
Else   // now check to see if the link is related to the current web author
	If ([Links:17]AuthorizedUser:13#webAuthor)
		checkAddError("This link cannot be used by this authorized channel.")
	End if 
End if 

QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=webForeignAccount)
If ([Accounts:9]Currency:6#webFromCurrency)
	checkAddError("Account "+[Accounts:9]AccountID:1+" cannot accept  "+webFromCurrency)
End if 


webFromAmountR:=Num:C11(webFromAmount)
webToAmountR:=Num:C11(webToAmount)

webRate:=String:C10(calcSafeDivide(webToAmountR; webFromAmountR))+" "+webToCurrency+"/"+webFromCurrency
webInverseRate:=String:C10(calcSafeDivide(webFromAmountR; webToAmountR))+" "+webFromCurrency+"/"+webToCurrency



If (checkErrorExist)
	//vErrorString:=checkGetErrorString 
	web_SendERRORPage($1)
Else 
	web_SendHTMLPage(->[eWires:13]; "Confirm"; "*")
End if 