
//If (Form event=On Load )
//DISABLE BUTTON(bBack)
//End if 
//
//If (Current form page=1)
//DISABLE BUTTON(bBack)
//Else 
//ENABLE BUTTON(bBack)
//End if 

If (Form event code:C388=On Close Box:K2:21)
	CANCEL:C270
End if 

//ALL RECORDS([Banks])
ALL RECORDS:C47([Wires:8])
