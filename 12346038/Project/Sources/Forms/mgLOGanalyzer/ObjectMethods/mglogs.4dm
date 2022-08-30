Case of 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Form:C1466.currLog#Null:C1517)
			
			C_LONGINT:C283($procid)
			
			$procid:=New process:C317("mgLOGopenInput"; 0; "edit_"+String:C10(Milliseconds:C459); Form:C1466.currLog)
			
		End if 
		
		
End case 
