//%attributes = {}
// makeEmailFromInvoiceBody


C_TEXT:C284($0)
C_LONGINT:C283($i; $n)
C_TEXT:C284($message; $record; $divider; $header; $signature)

$divider:="________________________________________________________"


$n:=Records in selection:C76([Registers:10])
READ ONLY:C145([Registers:10])
FIRST RECORD:C50([Registers:10])

RELATE ONE:C42([Bookings:50]CustomerID:2)  // load the customer 

$header:=replaceEmailTags(<>emailHeader)
$signature:=replaceEmailTags(<>emailSignature)


appendToString(->$message; $header; True:C214)

appendToString(->$message; $divider; True:C214)

appendLabelString(->$message; "Booking Reference:"; [Bookings:50]BookingID:1; True:C214)
appendLabelString(->$message; "Booking on:"; String:C10([Bookings:50]BookingDate:3)+" "+String:C10([Bookings:50]BookingTime:4; "HH:MM"); True:C214)
appendLabelString(->$message; "Value Date:"; String:C10([Bookings:50]ValueDate:26); True:C214)


appendLabelString(->$message; "Booked by "; [Bookings:50]BookedByUser:5; True:C214)
appendLabelString(->$message; "Booking done by "; [Bookings:50]BookingMethod:6; True:C214)

appendToString(->$message; $divider; True:C214)

appendLabelString(->$message; "Payment/Settlement Method:"; [Bookings:50]PaymentMethod:8; True:C214)

If ([Bookings:50]isSell:7)
	appendLabelString(->$message; "Customer Booked to PURCHASE:"; String:C10([Bookings:50]Amount:9; "|Currency")+" "+[Bookings:50]Currency:10; True:C214)
Else 
	appendLabelString(->$message; "Customer Booked to SELL:"; String:C10([Bookings:50]Amount:9; "|Currency")+" "+[Bookings:50]Currency:10; True:C214)
End if 


appendLabelString(->$message; "Direct Rate:"; String:C10([Bookings:50]ourRate:11; "|Rate"); True:C214)
appendLabelString(->$message; "Inverse Rate:"; String:C10([Bookings:50]inverseRate:29; "|Rate"); True:C214)

appendLabelString(->$message; "Booking Fee:"; String:C10([Bookings:50]feeLocal:22; "|Currency"); True:C214)
appendLabelString(->$message; "Commission%:"; String:C10([Bookings:50]percentFee:21); True:C214)
appendLabelString(->$message; "Local Amount:"; String:C10([Bookings:50]amountLocal:23; "|Currency")+" "+<>BASECURRENCY; True:C214)
appendLabelString(->$message; "Remarks:"; [Bookings:50]ourRemarks:13; True:C214)


For ($i; 1; $n)
	$record:=serializeRecRegister
	$message:=$message+$record+CRLF
	NEXT RECORD:C51([Registers:10])
End for 

appendToString(->$message; <>bookingDisclaimer; True:C214)
appendToString(->$message; $divider; True:C214)

appendToString(->$message; $signature; True:C214)

$0:=$message