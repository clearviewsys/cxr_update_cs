//%attributes = {}
//If (Application type#4D Server)
//If (Current user="User")
//displayUsersLogin 
//If (OK=0)
//setSystemUser 
//End if 
//Else 
//  //If (◊ApplicationUser#"LOCKED")
//setSystemUser 
//  //End if 
//End if 
//CALL PROCESS(-1)
//End if 


// new version 3.620
C_LONGINT:C283(<>LOGOFFPID)

If (Application type:C494#4D Server:K5:6)
	//Log user logging out
	LogUserLoggingOut(String:C10(getApplicationUser); getCurrentMachineName)
	
	//If (getKeyValue ("feature.hola";"false")="true")
	iH_unregisterClient  //unregister client name for Hola
	//End if 
	
	//End autoLogout process
	<>AutoLogoutContinue:=False:C215
	If (<>LOGOFFPID#0)
		DELAY PROCESS:C323(<>LOGOFFPID; 0)
	End if 
	
	// clear MoneyGram credentials
	mgCredentialsRemove
	
	displayUsersLogin_
	//setSystemUser 
	//CALL PROCESS(-1)
	
	If (Macintosh option down:C545=False:C215)
		mgEnterCredentials  // @milan 2021071
	End if 
	
End if 

