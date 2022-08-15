//%attributes = {"publishedWeb":true}
// USERSLogout

C_TEXT:C284($1)
If ($1#"")
	webContextID:=Substring:C12($1; 2)
End if 

If (webContextID#"")
	web_DeleteACTIVE_USERS(webContextID)
	web_SendUSERSLogin
Else 
	web_SendErrorMsg("There was no active session to log out from.")
End if 
