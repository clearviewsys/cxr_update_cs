C_TEXT:C284($sUser; $sSessionUser; $sProcessName)
C_LONGINT:C283($iProcess)

If (vUserName="Designer") | (vUserName="Administrator") | (vUserName="Support")
	changeUserPassword
Else 
	
	If (vUserName#"")
		QUERY:C277([Users:25]; [Users:25]UserName:3=vUserName)
		C_TEXT:C284($newPassword; vNewHint)
		vNewHint:=""
		$newPassword:=requestChangePassword([Users:25]Password:4)
		
		If ($newPassword#"")  // actually change the user's passwordç
			
			C_OBJECT:C1216($options)
			$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
			
			LOCKED BY:C353([Users:25]; $iProcess; $sUser; $sSessionUser; $sProcessName)
			
			// If the record is not locked, process returns 0 and 4Duser, sessionUser, and processName 
			// return empty strings. 
			// If the record you try to load in read/write has been deleted, process returns -1 and 
			// 4Duser, sessionUser, and processName return empty strings.
			
			Case of 
				: (($iProcess=0) & ($sUser+$sSessionUser+$sProcessName=""))  // No locked
					
					READ WRITE:C146([Users:25])
					
					LOAD RECORD:C52([Users:25])
					[Users:25]Password:4:=Generate password hash:C1533($newPassword; $options)
					[Users:25]isHashed:36:=True:C214
					[Users:25]forceResetDate:41:=Add to date:C393(Current date:C33; 0; <>PASSWORDRESETINTERVAL; 0)
					[Users:25]nextAttemptTime:34:=Time:C179(0)
					[Users:25]numAttempts:35:=0
					[Users:25]Reminder:5:=vNewHint
					SAVE RECORD:C53([Users:25])
					
					If (OK=1)
						addUsedPassword($newPassword)
						myAlert("Password changed successfuly!")
					Else 
						myAlert("Error saving new password. Please double check that the user record is not being edited elsewhere.")
						
					End if 
					UNLOAD RECORD:C212([Users:25])
					
					
				: (($iProcess=-1) & ($sUser+$sSessionUser+$sProcessName=""))  //the record you try to load in read/write has been deleted
					
					myAlert(Table name:C256(->[Users:25])+" has been deleted Please ensure the record is not deleted and try again")
					
				Else 
					myAlert(Table name:C256(->[Users:25])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName+CRLF+"Please ensure the record is not being edited on the system before trying again.")
			End case 
			
		End if   // ($newPassword#"") 
		
	End if 
	
End if 


UNLOAD RECORD:C212([Users:25])

