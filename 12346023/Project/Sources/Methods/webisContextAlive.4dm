//%attributes = {"publishedWeb":true}
// webIsContextAlive (contextID) -> boolean

// look for user in the contextID
// returns true if user is logged in

//TRACE

C_TEXT:C284($1)  //;$2;$3;$4)
C_BOOLEAN:C305($0)

//C_TEXT(webURLContext)

//If (Undefined(webURLContext))
//webURLContext:=""
//End if 



If (WAPI_isSessionAuthorized($1))  //;webURLContext))
	
	webUsername:=WAPI_getSession("username")
	webContext:=WAPI_getSession("context")
	WEBEMAILADDRESS:=WAPI_getSession("email")
	
	$0:=True:C214
	
	
	If (False:C215)
		If ((Current time:C178-[WebSessions:15]LastActivityTime:6)><>inactivityTimeAllowed)  // LOGOUT USER AFTER 10 MINUTES OF INACTIVITY
			DELETE RECORD:C58([WebSessions:15])
			UNLOAD RECORD:C212([WebSessions:15])
			webUsername:=""
			WEBEMAILADDRESS:=""
			webContext:=""
			$0:=False:C215
		Else   // ---------- THIS IS GOING TO BE WRITING ALOT AND PESTERING THE DATABASE - CAN WE DO SOMETHING IN MEMORY???? ------
			
			READ WRITE:C146([WebSessions:15])
			LOAD RECORD:C52([WebSessions:15])  // lock the record for modification
			[WebSessions:15]LastActivityTime:6:=Current time:C178  // update the last activity
			webUsername:=[WebSessions:15]webUsername:2
			webContext:=[WebSessions:15]webContext:8
			SAVE RECORD:C53([WebSessions:15])  // save the record
			UNLOAD RECORD:C212([WebSessions:15])  // unlock the record
			READ ONLY:C145([WebSessions:15])
			
			Case of 
				: (webContext="customers")
					QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webUsername)
					WEBEMAILADDRESS:=[WebUsers:14]Email:3
					
				: (webContext="agents")
					QUERY:C277([Agents:22]; [Agents:22]AgentID:1=webUsername)
					WEBEMAILADDRESS:=[Agents:22]email:8
					
				Else 
					
			End case 
			
			UNLOAD RECORD:C212([WebUsers:14])
			
			$0:=True:C214
		End if 
	End if 
	
	
	
Else   // context doesn't exist therefore user is already logged out
	$0:=False:C215
End if 
