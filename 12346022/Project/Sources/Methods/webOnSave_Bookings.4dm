//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/24/18, 21:36:17
// ----------------------------------------------------
// Method: webCreateBookings
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0)

C_TEXT:C284($tPayMethod)
C_BOOLEAN:C305($isReceived)

C_TEXT:C284($currency)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $amountLocalPtr; $inverseRatePtr)
C_POINTER:C301($amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $feeLocalPtr)


webSelectCustomerRecord
If ([Bookings:50]BookingID:1="")
	[Bookings:50]BookingID:1:=createSerializedID(->[Bookings:50]; 1000; "WEB")
End if 
[Bookings:50]CustomerID:2:=[Customers:3]CustomerID:1  //need to use web session to get customera id
[Bookings:50]BranchID:25:="WWW"
[Bookings:50]ValueDate:26:=Current date:C33(*)
[Bookings:50]BookingTime:4:=Current time:C178(*)
[Bookings:50]BookingDate:3:=Current date:C33(*)
[Bookings:50]BookedByUser:5:=WAPI_getSession("username")
[Bookings:50]expiryDate:16:=Current date:C33(*)+1
[Bookings:50]expiryTime:17:=Current time:C178(*)
[Bookings:50]BookingMethod:6:="WEB"

If ([Bookings:50]ourRemarks:13#"")
	[Bookings:50]ourRemarks:13:="Purpose: "+[Bookings:50]ourRemarks:13
End if 
If ([Bookings:50]autoComments:24#"")
	[Bookings:50]ourRemarks:13:=[Bookings:50]ourRemarks:13+Char:C90(Carriage return:K15:38)+"Source of funds: "+[Bookings:50]autoComments:24
	[Bookings:50]autoComments:24:=""
End if 

//[Bookings]PaymentMethod:=  //captured on web form
$tPayMethod:=[Bookings:50]PaymentMethod:8

Case of 
	: ($tPayMethod=c_Cash)
		[Bookings:50]AccountID:30:=makeCashAccountID([Bookings:50]Currency:10)
		
	Else 
		[Bookings:50]AccountID:30:=""  //agent will have to specify
End case 

//[Bookings]autoComments:=""`auto handled
//[Bookings]Currency:= `captured on web form
//[Bookings]ourRate:=  `handled in setExchangeRate
//[Bookings]inverseRate:=  `handled in setExchangeRate
//[Bookings]ourRemarks:=""
//[Bookings]percentFee:=  `not used for this example ???
//[Bookings]spotRate:=  `????
//FROM WEB WE HAVE THE FOLLOWING
//[Bookings]Amount  //from web form
//[Bookings]Currency  // from web form
//[Bookings]isSell

If ([Bookings:50]isOpenBooking:34)
	[Bookings:50]ourRate:11:=0
	[Bookings:50]percentFee:21:=0
	[Bookings:50]feeLocal:22:=0
	[Bookings:50]inverseRate:29:=0
	[Bookings:50]amountLocal:23:=0
Else 
	If (False:C215)  //all done in form with tiered rates
		pickCurrency(->[Bookings:50]Currency:10)
		setExchangeRate(->[Bookings:50]ourRate:11; ->[Bookings:50]inverseRate:29; getReceivedOrPayString(Num:C11(Not:C34([Bookings:50]isSell:7))); [Currencies:6]OurBuyRateLocal:7; [Currencies:6]OurSellRateLocal:8; True:C214)
		
		$isReceived:=Not:C34([Bookings:50]isSell:7)
		$currency:=[Bookings:50]Currency:10
		$amountPtr:=->[Bookings:50]Amount:9
		$ratePtr:=->[Bookings:50]ourRate:11
		$percentPtr:=->[Bookings:50]percentFee:21
		$feeLocalPtr:=->[Bookings:50]feeLocal:22
		$amountLocalPtr:=->[Bookings:50]amountLocal:23
		$inverseRatePtr:=->[Bookings:50]inverseRate:29  // changed by TB in version 3.485
		
		$amountLocalBFPtr:=->vAmountLocal_BF  //<-- talk to tiran
		$percentFeeLocalPtr:=->vPercentFeeLocal  //<-- talk to tiran
		$totalFeesPtr:=->vTotalFees  //<-- talk to tiran
		
		C_LONGINT:C283($switch)
		$switch:=5  //hard coded to local amount option button
		calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
	End if 
End if 

//webSendRecordChangeEmail (->[Bookings])

$0:=1  //save record - OK = 1