//%attributes = {}
C_TEXT:C284($0)


$0:="Reservation de taux pour "+[Customers:3]FullName:40+" pour "+String:C10([Bookings:50]Amount:9)+" "+[Bookings:50]Currency:10+" @"+String:C10([Bookings:50]ourRate:11)
If ([Bookings:50]isSell:7)
	$0:=$0+" pour acheter "
Else 
	$0:=$0+" pour vendre "
	
End if 

$0:=$0+" le "+String:C10([Bookings:50]BookingDate:3)+"."

If ([Bookings:50]isConfirmed:15)
	$0:=$0+". (confirmé par "+([Bookings:50]BookedByUser:5)+")"
Else 
	$0:=$0+". (pas confirme)"
End if 