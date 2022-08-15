//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/18/18, 20:21:20
// ----------------------------------------------------
// Method: webBookingsFormOnChange
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)


C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue; $tCurrCode)
C_BOOLEAN:C305($bRefreshRates; $isSell; $bOnDisplay)
C_REAL:C285($rBookAmt; $rAmt; $rFee)
C_BOOLEAN:C305($bOnLoad)
C_TEXT:C284($tTimer; $tGroup; $tCust)
C_LONGINT:C283($iElem)
C_TEXT:C284($tPayMethodLabel; $tLocalAmountLabel; $tAmountLabel; $tAmountPlaceholder)
C_TEXT:C284($tOurRateLabel; $tRateNotes)

$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$bRefreshRates:=False:C215
$bOnLoad:=False:C215
$tTimer:="5:00"



If (True:C214)  //------ GET BASE VALUES FOR ALL CALCULATIONS ---------
	
	If ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //ON LOAD phase new records
		$bOnLoad:=True:C214
	End if 
	
	If ($tEvent="readystatechange") | ($tEvent="load")  //ON LOAD phase for existing records in dialog
		$bOnDisplay:=True:C214
	End if 
	
	$tCurrCode:=WAPI_getInputValue(->[Bookings:50]Currency:10)
	READ ONLY:C145([Currencies:6])
	
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$tCurrCode)  //get the currency as current record
	
	$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[Bookings:50]isSell:7))  // we need to know if isSell
	If ($iElem>0)
		If ($ptrValueArray->{$iElem}="true")
			$isSell:=True:C214
		Else 
			$isSell:=False:C215
		End if 
	End if 
	
	$rBookAmt:=Num:C11(WAPI_getInputValue(->[Bookings:50]Amount:9))
	
	If (WAPI_getInputValue(->[Bookings:50]isOpenBooking:34)="on")
		$tTimer:="unlimited"
	End if 
	
	
	webSelectCustomerRecord
	
End if 



//------------- USER CLICKS THE REFRESH RATES BUTTON -----------
If ($tSource="rateRefresh")
	$bRefreshRates:=True:C214
End if 

//------ TIMER HAS EXPIRED ----------
If ($tSource="timer") & ($tEvent="expire")
	$bRefreshRates:=True:C214
End if 



//-- WHEN CUSTOMER IS BUYING -- WE ARE SELLING --

//--------------------- CHANGE IN BUY/SELL SELECT --------------------
If ($tSource=WAPI_getInputControlID(->[Bookings:50]isSell:7)) | ($bOnLoad) | ($bOnDisplay)
	
	If ($isSell)  //this is a customer BUY
		$tPayMethodLabel:="I would like to receive the currency via?"
		$tLocalAmountLabel:="I will pay:"
		$tAmountLabel:="Buy this amount for me"
		$tAmountPlaceholder:="The amount I want to buy"
		$tOurRateLabel:="My Buy Rate"
	Else   //customer SELL
		$tPayMethodLabel:="I will pay for this transaction via?"
		$tLocalAmountLabel:="I will receive:"
		$tAmountLabel:="Sell this amount for me"
		$tAmountPlaceholder:="The amount I want to sell"
		$tOurRateLabel:="My Sell Rate"
	End if 
	
	
	WAPI_pushDOMHTML(WAPI_getInputLabelID(->[Bookings:50]PaymentMethod:8); $tPayMethodLabel)
	WAPI_pushDOMHTML(WAPI_getInputLabelID(->[Bookings:50]amountLocal:23); $tLocalAmountLabel)
	WAPI_pushDOMPlaceholder(WAPI_getInputControlID(->[Bookings:50]Amount:9); $tAmountPlaceholder)
	WAPI_pushDOMHTML(WAPI_getInputLabelID(->[Bookings:50]Amount:9); $tAmountLabel)
	WAPI_pushDOMHTML(WAPI_getInputLabelID(->[Bookings:50]ourRate:11); $tOurRateLabel)
	
	$bRefreshRates:=True:C214  //need to update everything
	
End if 



//--------------------- CHANGE IN AMOUNT --------------------
If ($tSource=WAPI_getInputControlID(->[Bookings:50]Amount:9))  //| ($bOnLoad)
	$bRefreshRates:=True:C214
End if 



//-------- ISOPENBOOKING CHECKBOX -------
If ($tSource=WAPI_getInputControlID(->[Bookings:50]isOpenBooking:34))
	$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[Bookings:50]isOpenBooking:34))
	If ($iElem>0)
		If ($ptrValueArray->{$iElem}="on")
			
			WAPI_pushDOMVisible("rate-group"; False:C215)
			WAPI_pushDOMVisible("open-booking-notification"; True:C214)
			WAPI_pushDOMHTML("expiretimer"; "unlimited")  //disable timer
			
		Else 
			WAPI_pushDOMVisible("rate-group"; True:C214)
			WAPI_pushDOMVisible("open-booking-notification"; False:C215)
			//enable timer
			$bRefreshRates:=True:C214
		End if 
	Else 
		WAPI_pushDOMVisible("rate-group"; True:C214)
		WAPI_pushDOMVisible("open-booking-notification"; False:C215)
		
		//enable timer
		$bRefreshRates:=True:C214
	End if 
End if 



//---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
If ($tSource="agreement-input") | ($bOnLoad)  //checkbox to agree to conditions
	$iElem:=Find in array:C230($ptrNameArray->; $tSource)
	If ($iElem>0)
		If ($ptrValueArray->{$iElem}="on")
			WAPI_pushJs("$('#submit-input').removeAttr('disabled');")
		Else 
			WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
		End if 
	Else 
		WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
	End if 
End if 




//----------------------- CHANGE IN CURRENCY SELECT MENU -> OR ON LOADING --------------------
If ($tSource=WAPI_getInputControlID(->[Bookings:50]Currency:10)) | ($bOnLoad) | ($bOnDisplay)
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[Bookings:50]Amount:9); webGetFlag_Currency($tCurrCode))  //send image
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Bookings:50]Amount:9); $tCurrCode)  //SET THE ADDON POST
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Bookings:50]ourRate:11); <>BASECURRENCY+"/"+$tCurrCode)  //SET THE ADDON POST
	
	$bRefreshRates:=True:C214
End if 


//------ TIMER HAS EXPIRED-----------
If ($tSource="timer") & ($tEvent="expire")
	WAPI_pushDOMProperty("agreement-input"; "checked"; "false")
	WAPI_pushDOMProperty("submit-input"; "disabled"; "true")
	WAPI_pushDOMHTML("expirewarning"; "")
	WAPI_pushDOMHTML("timerAlertText"; "The timer has expired. Rates have refreshed please confirm...")
	WAPI_pushJs("$('#timerAlert').modal();")
	
	$bRefreshRates:=True:C214
End if 



Case of 
	: ($bOnLoad) & ($rBookAmt>0)  //EXISTING RECORD
		$bRefreshRates:=False:C215
		
	: ($bOnDisplay)  //---- VIEWING EXISTING BOOKING ---
		$bRefreshRates:=False:C215
		
End case 


//---------- UPDATE RATES -----------
If ($bRefreshRates)
	If (True:C214)  //new tiered rates calc
		
		C_OBJECT:C1216($o)
		C_REAL:C285($rRate; $rBase; $rFee; $rMargin)
		
		// $isSell=true = customer buy
		// $isSell=false = customer sell
		$o:=getTieredRate($tCurrCode; <>BASECURRENCY; $rBookAmt; $isSell=False:C215)
		$rRate:=Round:C94($o.rate; 6)
		$rBase:=Round:C94($o.base; 6)
		$rFee:=$o.fee
		$rMargin:=$o.margin
		$tGroup:=$o.group
		$tCust:=$o.customer
		
		If ($tCust="")
			$tCust:="N/A Cust"
		End if 
		
		If ($tGroup="")
			$tGroup:="N/A Group"
		End if 
		
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Bookings:50]ourRate:11); String:C10($rRate))
		
		$tRateNotes:="Inverse Rate: "+String:C10(1/$rRate)
		$tRateNotes:=$tRateNotes+" | "+$tCust+" | "+$tGroup+" | Base: "+String:C10($rBase)+" Margin: "+String:C10($rMargin)+" Fee: "+String:C10($rFee)
		
		If ($isSell)  //customer buy -- this is a sell for us
			$rAmt:=($rBookAmt*$rRate)+$rFee
		Else 
			$rAmt:=($rBookAmt*$rRate)-$rFee
		End if 
		
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Bookings:50]feeLocal:22); String:C10($rFee; "######0.00"))
		WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Bookings:50]feeLocal:22); <>BASECURRENCY)  //SET THE ADDON POST
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Bookings:50]amountLocal:23); String:C10($rAmt; "######0.00"))
		WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Bookings:50]amountLocal:23); <>BASECURRENCY)  //SET THE ADDON POST
		
		
		WAPI_pushDOMHTML("bookings-currency-rate-inverse"; $tRateNotes)  //SET THE INVERSE RATE TEXT
		WAPI_pushDOMHTML("bookings-currency-rate-updated"; "Updated: "+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178))
		WAPI_pushDOMHTML("expirewarning"; $tCurrCode+": Rates will refresh unless you book this in :")
		WAPI_pushDOMHTML("expiretimer"; $tTimer)  //reset the timer
		WAPI_pushJs("wapiStartTimer();")
		
		
	Else   //old method via [currencies]
		If ($isSell)
			$rFee:=$rBookAmt*0.01
			
			If (True:C214)  //direct rate
				$tResult:=$tResult+WAPI_setDOMValue(WAPI_getInputControlID(->[Bookings:50]ourRate:11); String:C10([Currencies:6]OurSellRateLocal:8))
				$tRateNotes:="Inverse Rate: "+String:C10([Currencies:6]OurSellRateInverse:26)
			Else   //inverse rate
				$tResult:=$tResult+WAPI_setDOMValue(WAPI_getInputControlID(->[Bookings:50]ourRate:11); String:C10([Currencies:6]OurSellRateInverse:26))
				$tRateNotes:="Direct Rate: "+String:C10([Currencies:6]OurSellRateLocal:8)
			End if 
			
			$rAmt:=($rBookAmt*[Currencies:6]OurSellRateLocal:8)+$rFee
			
		Else 
			$rFee:=$rBookAmt*0.01
			
			If (True:C214)  //direct rate
				$tResult:=$tResult+WAPI_setDOMValue(WAPI_getInputControlID(->[Bookings:50]ourRate:11); String:C10([Currencies:6]OurBuyRateLocal:7))
				$tRateNotes:="Inverse Rate: "+String:C10([Currencies:6]OurBuyRateInverse:25)
			Else   //inverse rate
				$tResult:=$tResult+WAPI_setDOMValue(WAPI_getInputControlID(->[Bookings:50]ourRate:11); String:C10([Currencies:6]OurBuyRateInverse:25))
				$tRateNotes:="Direct Rate: "+String:C10([Currencies:6]OurBuyRateLocal:7)
			End if 
			
			$rAmt:=($rBookAmt*[Currencies:6]OurBuyRateLocal:7)-$rFee
			
		End if 
		
	End if 
	
End if 


// ------- UPDATE MONEY/CCY  ----------


$0:=WAPI_pullJsStack  //$tResult