//%attributes = {}
If ([Bookings:50]isSell:7)
	[Bookings:50]Amount:9:=-Abs:C99([Bookings:50]Amount:9)
	[Bookings:50]amountLocal:23:=-Abs:C99([Bookings:50]amountLocal:23)
Else 
	[Bookings:50]Amount:9:=Abs:C99([Bookings:50]Amount:9)
	[Bookings:50]amountLocal:23:=Abs:C99([Bookings:50]amountLocal:23)
End if 

setBookingsAutoComment