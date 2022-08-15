//%attributes = {"publishedWeb":true}
C_TEXT:C284(webeWireID)

If (webisContextAlive(webContextID))
	QUERY:C277([eWires:13]; [eWires:13]eWireID:1=webeWireID)
	READ WRITE:C146([eWires:13])
	LOAD RECORD:C52([eWires:13])
	SetFieldsToVariables(->[eWires:13])
	
	
	web_ValidateeWires
	If (checkErrorExist)
		web_SendERRORPage
	Else 
		If (isCheckBoxSwitchedOn(->[eWires:13]isCancelled:34))  // the ewire got cancelled)
			[eWires:13]AccountID:30:="Cancelled"
		End if 
		
		createRegisterOfeWire
		SAVE RECORD:C53([eWires:13])
		//UNLOAD RECORD([eWires])
		READ ONLY:C145([eWires:13])
		web_SendUserAreaPage
	End if 
	
Else 
	web_SendContextExpiredPage
End if 