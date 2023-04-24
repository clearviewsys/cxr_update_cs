//%attributes = {}
var $winref : Integer

If (UTIL_isClientOnServerComputer)
	
	$winref:=Open form window:C675("b2_dialog")
	
	DIALOG:C40("b2_dialog")
	
	CLOSE WINDOW:C154($winref)
	
Else 
	
	ALERT:C41("Client should be running on the same computer 4D Server is running on!")
	
End if 
