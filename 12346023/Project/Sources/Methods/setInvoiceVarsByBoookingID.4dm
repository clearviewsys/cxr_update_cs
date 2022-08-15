//%attributes = {}
// setInvoiceVarsToBookingID (bookingID)

C_TEXT:C284($bookID; $1)
$bookID:=$1


queryByID(->[Bookings:50]; $bookID)
READ WRITE:C146([Bookings:50])
LOAD RECORD:C52([Bookings:50])
[Bookings:50]isHonored:18:=True:C214
[Bookings:50]invoiceID:19:=vInvoiceNumber
SAVE RECORD:C53([Bookings:50])

If ([Bookings:50]isSell:7)
	setReceivedOrPaid(2)
Else 
	setReceivedOrPaid(1)
End if 
setVecCurrency([Bookings:50]Currency:10; True:C214)
vecPaymentMethod{0}:=[Bookings:50]PaymentMethod:8

ARRAY TEXT:C222(vecAccounts; 1)
vecAccounts{0}:=[Bookings:50]AccountID:30
vecAccounts{1}:=[Bookings:50]AccountID:30
vecAccounts:=1
INV_vNextAccountID:=[Bookings:50]AccountID:30

OBJECT SET VISIBLE:C603(vecAccounts; True:C214)

setExchangeRate(->vRate; ->vInverseRate; vReceivedOrPaid; Abs:C99([Bookings:50]ourRate:11); Abs:C99([Bookings:50]ourRate:11); True:C214)

setRadioButtonStatesInInvoice(5)
vAmount:=Abs:C99([Bookings:50]Amount:9)
vAmountLocal:=Abs:C99([Bookings:50]amountLocal:23)
vPercentFee:=[Bookings:50]percentFee:21
vFeeLocal:=[Bookings:50]feeLocal:22

If ([Bookings:50]ValueDate:26>Current date:C33)
	myAlert("This is future transaction. Note: the date of the invoice has been changed to "+String:C10([Bookings:50]ValueDate:26))
	
	vInvoiceDate:=[Bookings:50]ValueDate:26
	vValueDate:=[Bookings:50]ValueDate:26
End if 