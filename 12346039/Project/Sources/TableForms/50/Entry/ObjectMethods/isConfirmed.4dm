If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([Bookings:50]isConfirmed:15)
		[Bookings:50]isCancelled:35:=False:C215
		[Bookings:50]BookedByUser:5:=getApplicationUser
	Else 
		[Bookings:50]BookedByUser:5:=""
	End if 
End if 