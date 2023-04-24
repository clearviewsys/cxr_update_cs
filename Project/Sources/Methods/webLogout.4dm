//%attributes = {"publishedWeb":true}



READ WRITE:C146([WebAccessLog:16])
QUERY:C277([WebAccessLog:16]; [WebAccessLog:16]sessionID:8=WEB Get current session ID:C1162)

If (Records in selection:C76([WebAccessLog:16])=1)
	[WebAccessLog:16]logoutDate:6:=Current date:C33(*)
	[WebAccessLog:16]logoutTime:7:=Current time:C178(*)
	SAVE RECORD:C53([WebAccessLog:16])
End if 

WEBCONTEXT:=WAPI_getSession("context")
WAPI_clearSession
WAPI_createSession
WAPI_setSession("context"; webContext)

webUsername:=""
WAPI_setAlertMessage("Your session has been closed"; 1)

//WEB SEND FILE("/login.shtml")
webSendLoginPage