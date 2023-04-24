C_POINTER:C301($p_enteredCode)
C_TEXT:C284($enteredCode)

C_TEXT:C284($sUser; $sSessionUser; $sProcessName)
C_LONGINT:C283($iProcess)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$p_enteredCode:=OBJECT Get pointer:C1124(Object named:K67:5; "CodeEntryField")
		$enteredCode:=$p_enteredCode->
		
		If ($enteredCode=Form:C1466.resetCode)
			QUERY:C277([Users:25]; [Users:25]UserID:1=Form:C1466.userId)
			C_TEXT:C284($newPassword; vNewHint)
			vNewHint:=""
			$newPassword:=requestChangePasswordCodeValid([Users:25]Password:4)
			If ($newPassword#"")  // actually change the user's password
				C_OBJECT:C1216($options)
				$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
				If (Locked:C147([Users:25]))
					LOCKED BY:C353([Users:25]; $iProcess; $sUser; $sSessionUser; $sProcessName)
					myAlert(Table name:C256(->[Users:25])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName+\
						" Please ensure the record is not being edited on the system before trying again")
				Else 
					READ WRITE:C146([Users:25])
					LOAD RECORD:C52([Users:25])
					[Users:25]Password:4:=Generate password hash:C1533($newPassword; $options)
					[Users:25]isHashed:36:=True:C214
					[Users:25]forceResetDate:41:=Add to date:C393(Current date:C33; 0; <>PASSWORDRESETINTERVAL; 0)
					[Users:25]nextAttemptTime:34:=Time:C179(0)
					[Users:25]numAttempts:35:=0
					[Users:25]Reminder:5:=vNewHint
					SAVE RECORD:C53([Users:25])
					UNLOAD RECORD:C212([Users:25])
					If (OK=1)
						addUsedPassword($newPassword)
						myAlert("Password changed successfuly!")
					Else 
						myAlert("Error saving new password. Please double check that the user record is not being edited elsewhere.")
					End if 
				End if 
			End if 
		Else 
			myAlert("Entered Code does not match or may be expired."+Char:C90(Carriage return:K15:38)+\
				"Please double check your reset code."+Char:C90(Carriage return:K15:38)+\
				"If the error persists, please contact your system administrator.")
			REJECT:C38
		End if 
End case 

