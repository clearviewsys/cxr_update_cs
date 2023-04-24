//%attributes = {"publishedWeb":true}
C_REAL:C285(webFromAmountR; webToAmountR)
C_TEXT:C284(webFromAmount; webToAmount)
C_TEXT:C284(webLinkID; webFromName; webToName; webFromCurrency; webToCurrency)
C_TEXT:C284(webChannelConfirmationNo)

checkInit
//checkIfNullString (->webCustomerName;"Customer Name")  ` for mandatory strings
checkIfNullString(->webLinkID; "Link ID")  // for mandatory strings
checkIfNullString(->webFromCurrency; "From Currency")

//checkIfNullString (->webToCurrency;"To Currency")
checkIfNullString(->webFromAmount; "From Amount")

webFromAmountR:=Num:C11(webFromAmount)
webToAmountR:=Num:C11(webToAmount)

checkGreaterThan(->webFromAmountR; "From Amount"; 0)
checkLowerBound(->webToAmountR; "To Amount"; 0)
checkUniqueness(->[eWires:13]; ->[eWires:13]ReferenceNo:28; ->webChannelConfirmationNo; "Agent Confirmation No.")


If (checkErrorExist)
	//vErrorString:=checkGetErrorString 
	web_SendERRORPage($1)
Else 
	START TRANSACTION:C239
	
	TM_Add2Stack(->[eWires:13]; Current method name:C684; Transaction level:C961)
	
	CREATE RECORD:C68([eWires:13])
	SetFieldsToVariables(->[eWires:13])
	[eWires:13]eWireID:1:=makeeWireID
	createRegisterOfeWire
	
	SAVE RECORD:C53([eWires:13])
	
	VALIDATE TRANSACTION:C240
	
	TM_RemoveFromStack
	
	web_SendUserAreaPage
End if 