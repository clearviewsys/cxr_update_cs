C_POINTER:C301($deviceIDs_popup_ptr)

$deviceIDs_popup_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "deviceIDs")

If ($deviceIDs_popup_ptr-><=Size of array:C274($deviceIDs_popup_ptr->))
	
	Form:C1466.credentials.agentID:=$deviceIDs_popup_ptr->{$deviceIDs_popup_ptr->}
	
End if 

