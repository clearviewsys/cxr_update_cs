C_TEXT:C284(<>SystemUser; <>ApplicationUser)
C_PICTURE:C286(<>userPicture)
C_TEXT:C284(vPassword)
C_BOOLEAN:C305($valid)

If (Form event code:C388=On Clicked:K2:4)
	
	If (True:C214)
		
		usersLoginbtn_OM
		
		// usersLoginbtn1_OM
		
	Else 
		
		// old code before LDAP & SSO
		
		If ((arrUserNames>0) & (arrUserNames<4))  // system users picked were Designer, Administrator, or Support Staff
			
			//Check if the designer account has been locked due to too many attempts
			If (isDesignerEnabled)
				//TRACE
				If (Validate password:C638(arrUserNames{arrUserNames}; vPassword))
					
					autoLogoutStart
					
					//If successful sign in for Designer, reset number of attempts
					resetDesignerAttempts
					
					CHANGE CURRENT USER:C289(arrUserNames{arrUserNames}; vPassword)  // this is successful sign-in for super users
					setSystemUser(vUserName)
					LogUserLoggingIn(vUserName; getCurrentMachineName)
					
					
					//If (getKeyValue ("feature.hola";"false")="true")
					iH_registerClient(getSystemUserName)  //IBB 1/28/20
					//End if 
					//Check admin password, and promt user to change it if it is not secure
					If ((arrUserNames=2) & (vPassword="admin@"))  // admin
						myAlert("This password is not secure. Please change it now!")
						REJECT:C38
					Else 
						POST OUTSIDE CALL:C329(-1)  // update the browser interprocess variables
						ACCEPT:C269
					End if 
					
					
				Else 
					//If password is incorrect and user is Designer, increase number of attempts
					checkDesignerAttempts
					BEEP:C151
					REJECT:C38
				End if 
			End if 
			
		Else   // system users were not picked
			READ WRITE:C146([Users:25])
			LOAD RECORD:C52([Users:25])
			
			checkInit
			checkAddErrorIf((([Users:25]nextAttemptTime:34#Time:C179(0)) & (Current time:C178<[Users:25]nextAttemptTime:34)); \
				"Too many attempts, please wait "+String:C10([Users:25]nextAttemptTime:34-Current time:C178)+" before trying again")
			checkAddErrorIf(((vUserName=[Users:25]UserName:3) & ([Users:25]isHashed:36#True:C214)); \
				"We have recently updated our password system."+\
				Char:C90(Carriage return:K15:38)+\
				"Please change your password to ensure all security features are in use")
			
			If (isValidationConfirmed(True:C214))
				If ((vUserName=[Users:25]UserName:3) & (Verify password hash:C1534(vPassword; [Users:25]Password:4)))
					checkInit
					checkAddErrorIf(checkPasswordExpired([Users:25]forceResetDate:41); "This password has expired, please change it now")
					If (isValidationConfirmed(True:C214))
						
						autoLogoutStart
						
						<>systemUser:=Current user:C182
						setApplicationUser([Users:25]UserName:3)
						<>UserID:=[Users:25]UserID:1
						<>userPicture:=[Users:25]Picture:6
						[Users:25]numAttempts:35:=0
						[Users:25]nextAttemptTime:34:=Time:C179(0)
						LogUserLoggingIn(vUserName; getCurrentMachineName)
						
						//If (getKeyValue ("feature.hola";"false")="true")
						iH_registerClient([Users:25]UserName:3)  //IBB 1/28/20
						//End if 
						
						POST OUTSIDE CALL:C329(-1)  // update the browser interprocess variables
						ACCEPT:C269
					End if 
				Else 
					
					If (vUserName=[Users:25]UserName:3)
						GOTO OBJECT:C206(vPassword)
					Else 
						GOTO OBJECT:C206(vUserName)
					End if 
					
					vCountTries:=vCountTries+1
					[Users:25]numAttempts:35:=[Users:25]numAttempts:35+1
					checkUserAttempts
					
				End if 
			End if 
			SAVE RECORD:C53([Users:25])
			UNLOAD RECORD:C212([Users:25])
			//End if 
			//End if 
		End if 
		
	End if 
	
End if 