C_LONGINT:C283($iError; $iStatus)

$iStatus:=confirmationTimeOut
$iError:=confirmationSetStatus([Confirmations:153]confirmationID:2; $iStatus; getSystemUserName; confirmationGetStatusText($iStatus))

If ($iError=0)
	CANCEL:C270
Else 
	myAlert("An error occurred setting the status. "+String:C10($iError))
	REJECT:C38
End if 