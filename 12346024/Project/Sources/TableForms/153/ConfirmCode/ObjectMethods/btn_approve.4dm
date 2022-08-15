C_LONGINT:C283($iError)

$iError:=confirmationSetStatus([Confirmations:153]confirmationID:2; confirmationApprove; getSystemUserName; OBJECT Get pointer:C1124(Object named:K67:5; "Confirmed_Reason")->)

If ($iError=0)
	CANCEL:C270
Else 
	myAlert("An error occurred setting the status. "+String:C10($iError))
	REJECT:C38
End if 