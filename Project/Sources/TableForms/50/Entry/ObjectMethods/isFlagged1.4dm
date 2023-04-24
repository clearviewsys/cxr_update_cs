If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ([Bookings:50]isOpenBooking:34=True:C214)
		[Bookings:50]ourRate:11:=0
		[Bookings:50]inverseRate:29:=0
	Else 
		[Bookings:50]ourRate:11:=Old:C35([Bookings:50]ourRate:11)
		[Bookings:50]inverseRate:29:=Old:C35([Bookings:50]inverseRate:29)
	End if 
	
End if 