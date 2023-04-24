C_TEXT:C284($isDisplayAddress; $isDisplayPhone; $isDisplayPurposeOfTransaction; $isDisplaySignature; $isDisplaySourceOfFunds; $isDoNotAskAgain)


If (Form event code:C388=On Load:K2:1)
	$isDisplaySignature:=getKeyValue("print.format.isDisplaySignature"; "false")
	If ($isDisplaySignature="true")
		Form:C1466.isDisplaySignature:=True:C214
	End if 
	
	$isDisplayAddress:=getKeyValue("print.format.isDisplayAddress"; "false")
	If ($isDisplayAddress="true")
		Form:C1466.isDisplayAddress:=True:C214
	End if 
	
	$isDisplayPhone:=getKeyValue("print.format.isDisplayPhone"; "false")
	If ($isDisplayPhone="true")
		Form:C1466.isDisplayPhone:=True:C214
	End if 
	
	$isDisplaySourceOfFunds:=getKeyValue("print.format.isDisplaySourceOfFunds"; "false")
	If ($isDisplaySourceOfFunds="true")
		Form:C1466.isDisplaySourceOfFunds:=True:C214
	End if 
	
	$isDisplayPurposeOfTransaction:=getKeyValue("print.format.isDisplayPurposeOfTransaction"; "false")
	If ($isDisplayPurposeOfTransaction="true")
		Form:C1466.isDisplayPurposeOfTransaction:=True:C214
	End if 
	
	$isDoNotAskAgain:=getKeyValue("print.format.isDoNotAskAgain"; "false")
	If ($isDoNotAskAgain="true")
		Form:C1466.isDoNotAskAgain:=True:C214
	End if 
End if 