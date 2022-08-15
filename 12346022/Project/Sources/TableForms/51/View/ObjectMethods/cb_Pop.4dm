C_OBJECT:C1216($obj; $status)
If (Form event code:C388=On Load:K2:1)
	$obj:=ds:C1482.CallLogs.query("CallLogID = :1"; [CallLogs:51]CallLogID:1)[0]
	If ($obj.doPopUp)
		Self:C308->:=1
	Else 
		Self:C308->:=0
	End if 
End if 


If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	$obj:=ds:C1482.CallLogs.query("CallLogID = :1"; [CallLogs:51]CallLogID:1)[0]
	$obj.doPopUp:=Not:C34($obj.doPopUp)
	$status:=$obj.save()
End if 