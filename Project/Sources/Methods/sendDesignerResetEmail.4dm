//%attributes = {}
C_TEXT:C284($body)

$body:="The designer acccount was reset on machine: "+getCurrentMachineName+" at : "+String:C10(Current date:C33)+" "+String:C10(Current time:C178)
If (Not:C34(vUserName=""))
	$body:=$body+" by user: "+vUserName
End if 
sendEmailHardCode("support@clearviewsys.com"; "Designer lockout reset"; $body)