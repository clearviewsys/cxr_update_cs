//%attributes = {}
C_BOOLEAN:C305($isPaid; $isReceived)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
C_TEXT:C284($currency; vCurrency)

HandleEntryFormMethod
// handleEntryForm

If (Form event code:C388=On Load:K2:1)
	
	RELATE ONE:C42([Bookings:50]CustomerID:2)
	RELATE ONE:C42([Bookings:50]Currency:10)
	setRadioButtonStatesInInvoice(5)
	
End if 

Case of 
	: (onNewRecordEvent)
		If (getNextCustomer#"")
			[Bookings:50]BookingID:1:=makeBookingID
			[Bookings:50]CustomerID:2:=getNextCustomer
			
			initNextCustomer
			RELATE ONE:C42([Bookings:50]CustomerID:2)
			//SET ENTERABLE([Bookings]CustomerID;False)
			[Bookings:50]ValueDate:26:=Current date:C33
			
		End if 
End case 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1))
	
	//_______________________________HANDLING THE LITTLE IMBEDDED CALCULATOR_________________________
	
	$isReceived:=Not:C34([Bookings:50]isSell:7)
	$currency:=[Bookings:50]Currency:10
	
	$amountPtr:=->[Bookings:50]Amount:9
	$ratePtr:=->[Bookings:50]ourRate:11
	$percentPtr:=->[Bookings:50]percentFee:21
	$feeLocalPtr:=->[Bookings:50]feeLocal:22
	$amountLocalPtr:=->[Bookings:50]amountLocal:23
	$inverseRatePtr:=->[Bookings:50]inverseRate:29  // changed by TB in version 3.485
	
	$amountLocalBFPtr:=->vAmountLocal_BF
	$percentFeeLocalPtr:=->vPercentFeeLocal
	$totalFeesPtr:=->vTotalFees
	
	//@Zoya Sep 2021
	Case of 
		: ([Bookings:50]PaymentMethod:8="Wire")
			OBJECT SET ENABLED:C1123(*; "Button1"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Button2"; False:C215)
			
		: ([Bookings:50]PaymentMethod:8="eWire")
			OBJECT SET ENABLED:C1123(*; "Button2"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Button1"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "Button2"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Button1"; False:C215)
	End case 
	
	C_LONGINT:C283($switch; rb1; b2; rb3; rb4; rb5)
	$switch:=getRadioButtonsSelection(rb1; rb2; rb3; rb4; rb5)
	calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
	//_________________________________________________________________________________________
	
	handleBookingStamp
End if 