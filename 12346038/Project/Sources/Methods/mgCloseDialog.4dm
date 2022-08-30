//%attributes = {}
// TRACE

If (Form:C1466.WebewireID#Null:C1517)
	If (Form:C1466.WebewireID#"")
		
		// ALERT("Web Ewire created with ID: "+Form.WebewireID)
		myAlert("MoneyGram transaction created with ID: "+Form:C1466.WebewireID)
		
	End if 
End if 

ACCEPT:C269
