C_DATE:C307($date)
C_LONGINT:C283($n)
$date:=requestDate

If (OK=1)
	myConfirm("Change selected workstations to "+String:C10($date))
	If (OK=1)
		READ WRITE:C146([MACs:18])
		USE SET:C118("$MACS_LBSet")
		$n:=Records in selection:C76([MACs:18])
		If ($n>0)
			APPLY TO SELECTION:C70([MACs:18]; [MACs:18]ExpirationDate:2:=$date)
			APPLY TO SELECTION:C70([MACs:18]; [MACs:18]isEmergencyActivated:22:=False:C215)
			
		Else 
			myAlert("No records selected")
		End if 
		READ ONLY:C145([MACs:18])
	End if 
End if 