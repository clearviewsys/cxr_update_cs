//%attributes = {"executedOnServer":true}
// clears MG Log object in server Storage object by creatin empty collection

If (Storage:C1525.mgLOG=Null:C1517)
Else 
	
	Use (Storage:C1525)
		Use (Storage:C1525.mgLOG)
			Storage:C1525.mgLOG:=New shared collection:C1527
		End use 
	End use 
	
End if 
