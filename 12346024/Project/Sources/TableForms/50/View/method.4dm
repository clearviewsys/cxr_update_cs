handleViewForm

C_BOOLEAN:C305($cond)
$cond:=(Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Printing Detail:K2:18)

If ($cond)
	RELATE ONE:C42([Bookings:50]CustomerID:2)
	RELATE ONE:C42([Bookings:50]Currency:10)
	//hideObjectsOnTrue (([Bookings]isConfirmed);"QuoteStamp")
	C_TEXT:C284($text)
	handleBookingStamp
	
End if 