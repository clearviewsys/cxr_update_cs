//%attributes = {"publishedWeb":true}

C_BOOLEAN:C305($success)
C_TEXT:C284($tValue)

If (getKeyValue("web.customers.login.invite.only")="true")
	$tValue:=WAPI_getParameter("invitationCode")
	If ($tValue=getKeyValue("web.customers.login.invite.code"))
	Else 
		checkAddError("Invalid invitation code.")
	End if 
End if 


C_OBJECT:C1216($entity)
$entity:=ds:C1482.WebUsers.query("webUsername == :1"; WAPI_getParameter("userName"))
If ($entity.length>0)  // already exists ... don't create another
	checkAddError("User account already exists for: "+WAPI_getParameter("userName"))
End if 


If (checkErrorExist)
	$success:=False:C215
Else 
	If (checkWarningExist)  // if there is a warning
		$success:=False:C215
	Else 
		$success:=True:C214
	End if 
End if 

$0:=$success

