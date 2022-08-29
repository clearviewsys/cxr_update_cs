//%attributes = {"publishedWeb":true}
// webBUSERSlogin
// PRE: vLoginID must be valid, webPassword must be sent
// PRE: vClientIP must be valid
// POST: webContextID will be generated

C_TEXT:C284(webLoginID; webPassword)
C_TEXT:C284(webClientIP)
C_TEXT:C284($1; webPostMethod)

If ($1#"")
	webPostMethod:=Substring:C12($1; 2)
End if 

If (webLoginID#"")
	// DO NOT CHANGE DO THIS QUERY WITH SelectUSER
	// because the password  will be automatically entered for the user
	
	QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webLoginID)
	// first check if user is already logged in
	
	If (web_IsUSERLoggedin(webLoginID))  //user is already logged in 
		web_LoadACTIVE_USERS(webLoginID)
		If ([WebSessions:15]IPNumber:3=webClientIP)  // if users has logged in from same IP 
			
			If ([WebUsers:14]Password:2=webPassword)
				RELATE ONE:C42([WebSessions:15]webUsername:2)
				web_SendUserAreaPage  // TERMINAL STATEMENT 
			Else 
				initializeVariables(->[WebUsers:14])
				web_SendErrorMsg("Invalid Password")  // TERMINAL STATEMENT
			End if 
			
		Else   // users had logged in from different IPs
			web_SendErrorMsg("This user account has already signed in from another machine.")  //  TERMINAL STATEMENT
			web_ACTIVE_USERSLogout(webContextID)
			
			webPassword:=""
		End if 
		
	Else   // user is not logged in so check password
		
		If ([WebUsers:14]isAllowedAccess_NU:5=True:C214)  // user is allowed web access
			
			If ([WebUsers:14]Password:2=webPassword)
				// assert password is correct      
				web_CreateACTIVE_USERS(webLoginID)
				
				If (webPostMethod="")
					web_SendUserAreaPage
				Else 
					EXECUTE FORMULA:C63(webPostMethod)  // TERMINAL STATEMENT
				End if 
				
			Else   // password is incorrect
				initializeVariables(->[WebUsers:14])
				web_SendErrorMsg("Invalid Password has been used.")  // TERMINAL STATEMENT
			End if 
		Else   // users IN NOT ALLOWED ACCESS 
			
			web_SendErrorMsg("You are not allowed to access the web. Please contact the administrator.")  // TERMINAL STATEMENT
			
		End if 
		
	End if 
	
Else 
	web_SendErrorMsg("User Login ID cannot be blank.")
End if 
