//%attributes = {}
C_TEXT:C284($text)

Case of 
	: (Not:C34([Bookings:50]isConfirmed:15) & Not:C34([Bookings:50]isHonored:18) & Not:C34([Bookings:50]isCancelled:35))  // not confirmed, cancelled or honored
		stampText("stamp"; "Pending ⚠"; "red")
		
	: (Not:C34([Bookings:50]isConfirmed:15) & Not:C34([Bookings:50]isOpenBooking:34) & Not:C34([Bookings:50]isCancelled:35))
		stampText("stamp"; "Quote ⚠"; "grey")
	: (([Bookings:50]isConfirmed:15) & ([Bookings:50]isOpenBooking:34) & Not:C34([Bookings:50]isCancelled:35) & Not:C34([Bookings:50]isHonored:18))
		stampText("stamp"; "Open "; "blue")
	: (([Bookings:50]isConfirmed:15) & Not:C34([Bookings:50]isHonored:18))
		stampText("stamp"; "Confirmed ☑"; "green")
	: ([Bookings:50]isHonored:18)
		stampText("stamp"; "Done 💁"; "black")
End case 

If ([Bookings:50]isCancelled:35)
	stampText("stamp_buy"; "Cancelled"; "red")
Else 
	Case of 
		: (([Bookings:50]isSell:7) & ([Bookings:50]isHonored:18=False:C215))
			$text:="⤴ Customer wants to buy <X> from us!"
			replaceXYZTags(->$text; [Bookings:50]Currency:10)
			stampText("stamp_buy"; $text; "black")
			
		: (([Bookings:50]isSell:7=False:C215) & ([Bookings:50]isHonored:18=False:C215))
			$text:="⤵ Customer wants to sell <X> to us!"
			replaceXYZTags(->$text; [Bookings:50]Currency:10)
			stampText("stamp_buy"; $text; "blue")
			
		: (([Bookings:50]isSell:7) & ([Bookings:50]isHonored:18=True:C214))
			$text:="Customer bought <X> from us! ✔"
			replaceXYZTags(->$text; [Bookings:50]Currency:10)
			stampText("stamp_buy"; $text; "black")
			
		: (([Bookings:50]isSell:7=False:C215) & ([Bookings:50]isHonored:18=True:C214))
			$text:="Customer sold <X> to us! ✔"
			replaceXYZTags(->$text; [Bookings:50]Currency:10)
			stampText("stamp_buy"; $text; "blue")
			
		Else 
			stampText("stamp_buy"; "Status Unknown ❓")
	End case 
End if 