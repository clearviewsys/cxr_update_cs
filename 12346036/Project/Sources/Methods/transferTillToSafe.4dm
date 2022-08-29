//%attributes = {}
//transferTillToSafe
// this method must be called from the invoice entry form only

C_TEXT:C284($till; $safe)
$till:=requestTillNo("Close which Till?")
If (OK=1)
	$safe:=requestTillNo("Which till to transfer to?")
	If (OK=1)
		If (($till#$safe) & ($safe#""))
			transferFromTilltoTill($till; $safe)
		Else 
			myAlert("Cannot transfer till into itself. ")
		End if 
		//REDRAW WINDOW()
	End if 
End if 