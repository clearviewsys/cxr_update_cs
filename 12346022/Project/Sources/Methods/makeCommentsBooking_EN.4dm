//%attributes = {}
C_TEXT:C284($0)


$0:=[Customers:3]FullName:40+" booked "+String:C10([Bookings:50]Amount:9)+" "+[Bookings:50]Currency:10+" @"+String:C10([Bookings:50]ourRate:11)
If ([Bookings:50]isSell:7)
	$0:=$0+" for purchase "
Else 
	$0:=$0+" for selling "
	
End if 

$0:=$0+" on "+String:C10([Bookings:50]BookingDate:3)+"."
If ([Bookings:50]ValueDate:26#nullDate)
	$0:=$0+" Value date:"+String:C10([Bookings:50]ValueDate:26)+"."
End if 

If ([Bookings:50]isConfirmed:15)
	$0:=$0+". (confirmed by "+([Bookings:50]BookedByUser:5)+")"
Else 
	$0:=$0+". (quote)"
End if 