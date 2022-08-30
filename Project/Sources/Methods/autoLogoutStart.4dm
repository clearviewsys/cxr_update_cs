//%attributes = {}

// @blake why no comments; what is this method doing? @tiran

C_LONGINT:C283($Pid)

If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Local mode:K5:1))
	If (Process number:C372("$AutoLogoutProcess")=0)
		If (<>AUTOLOGOUTENABLED)
			<>LOGOFFUSERPRESENT:=False:C215
			<>AutoLogoutContinue:=True:C214
			$Pid:=New process:C317("autoLogoutExecute"; 0; "$AutoLogoutProcess")
		End if 
	End if 
End if 