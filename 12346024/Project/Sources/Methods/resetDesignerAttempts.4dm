//%attributes = {}
//Method: resetDesignerAttempts
//Purpose: On successful login, if the user is Designer, 
//         reset the designer attempts and mark the account as enabled
//Returns: void

If (arrUserNames{arrUserNames}="Designer")
	setKeyValue("auth.designerTries"; "0")
	setKeyValue("auth.designerEnabled"; "True")
End if 