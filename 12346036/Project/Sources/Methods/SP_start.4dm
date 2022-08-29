//%attributes = {}

C_LONGINT:C283($iProcess)

If (Application type:C494=4D Remote mode:K5:5)
	//only runs on server
Else 
	$iProcess:=SP_managerProcess
End if 