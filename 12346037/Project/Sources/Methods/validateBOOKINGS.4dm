//%attributes = {}
//checkUniqueKey (->[Bookings];->[Bookings]BookingID;"BookingID")

//@Zoya- Modified Nov 2021 
checkifRecordExists(->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; ->[Bookings:50]Currency:10; "Currency Code")

If ([Bookings:50]isOpenBooking:34=False:C215)
	checkGreaterThan(->[Bookings:50]ourRate:11; "Booked Rate"; 0)
End if 
checkIfDateIsFilled(->[Bookings:50]ValueDate:26; True:C214; "Value Date")
checkIfNullString(->[Bookings:50]CustomerID:2; "Customer ID")

checkAddErrorIf(([Bookings:50]Amount:9=0); "Booked Amount can't be zero")
checkAddErrorIf([Bookings:50]CustomerID:2=getWalkInCustomerID; "Cannot book a rate for a walk-in customer!")

//@Zoya added Nov 2021
checkAddErrorIf([Bookings:50]CustomerID:2="000"; "Cannot book a rate for a walk-in customer!")

If ([Bookings:50]PaymentMethod:8="Wire") | ([Bookings:50]PaymentMethod:8="eWire")
	checkAddErrorIf(([Bookings:50]ourRemarks:13=""); "Please pick a recipient!")
End if 

If (Not:C34([Bookings:50]isConfirmed:15))
	checkAddWarning("This booking is not confirmed.")
End if 

checkAddErrorIf(Old:C35([Bookings:50]isHonored:18); "This Booking has been honored and cannot be modified")

If (([Bookings:50]isCancelled:35) & ([Bookings:50]isConfirmed:15))
	checkAddError("Booking cannot be cancelled and confirmed at the same time")
End if 


