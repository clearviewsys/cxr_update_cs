//@Zoya - Amended to populate links related to the changed Customr 

If (Form event code:C388=On Clicked:K2:4) & (Self:C308->#[Bookings:50]CustomerID:2)
	C_BOOLEAN:C305($isEnabled)
	$isEnabled:=OBJECT Get enabled:C1079(Self:C308->)
	If ($isEnabled)
		Self:C308->:=""
		pickCustomer(Self:C308)
	End if 
Else 
	
	//If (Form event=On Data Change)
	[Bookings:50]ourRemarks:13:=""
	
	pickCustomer(Self:C308)
	RELATE ONE:C42([Bookings:50]CustomerID:2)
	//End if 
End if 

//GOTO OBJECT([Bookings]isSell)