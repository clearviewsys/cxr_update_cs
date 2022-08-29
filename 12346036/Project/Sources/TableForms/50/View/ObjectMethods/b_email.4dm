READ ONLY:C145([Customers:3])
RELATE ONE:C42([Bookings:50]CustomerID:2)  // 
If ([Customers:3]Email:17#"")
	OpenEmailURL([Customers:3]Email:17+"?subject="+"Booking confirmation: "+[Bookings:50]BookingID:1+"&body="+makeEmailBodyForBooking)
Else 
	myAlert("Email not available for customer <X>."; [Customers:3]FullName:40)
End if 