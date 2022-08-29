C_LONGINT:C283($iError)


If (OBJECT Get pointer:C1124(Object named:K67:5; "Confirmed_Reason")->="")
	myAlert("Please document the reason for this denial.")
	REJECT:C38
Else 
	$iError:=confirmationSetStatus([Confirmations:153]confirmationID:2; confirmationDeny; getSystemUserName; OBJECT Get pointer:C1124(Object named:K67:5; "Confirmed_Reason")->)
	
	If ($iError=0)
		CANCEL:C270
	Else 
		myAlert("An error occurred setting the status. "+String:C10($iError))
		REJECT:C38
	End if 
End if 