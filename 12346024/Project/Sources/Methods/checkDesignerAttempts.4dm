//%attributes = {}
//Method: checkDesignerAttempts
//Purpose: On failed desinger login, increase the number of attempts,
//         if designer attempts >=10, disable designer
//Returns: void

If (arrUserNames{arrUserNames}="Designer")
	setKeyValue("auth.designerTries"; String:C10(Num:C11(getKeyValue("auth.DesignerTries"))+1))
	
	//If the password is incorrect and there have been 10 attempts to designer, disable designer account
	If (Num:C11(getKeyValue("auth.designerTries"))>=10)
		setKeyValue("auth.designerEnabled"; "False")
	End if 
End if 