//%attributes = {}
// handleeWiresFormMethod (isPaymentSent:bool)
If (False:C215)
	C_PICTURE:C286(latestListCheckBeneficiary4)
	C_PICTURE:C286(latestListCheckBeneficiary5)
	C_PICTURE:C286(latestListCheckBeneficiary8)
End if 
C_BOOLEAN:C305($1; $isPaymentSent)

$isPaymentSent:=($1)

If ($isPaymentSent)
	setFormTitle("Send eWire Form")
Else 
	setFormTitle("Receive eWire Form")
End if 

If (onNewRecordEvent)
	UNLOAD RECORD:C212([Agents:22])  // do not want to see any record loaded from the agents table
	
	seteWireFieldsToInvoiceVars($isPaymentSent; makeeWireID)
	If ($isPaymentSent)
		[eWires:13]SenderName:7:=[Invoices:5]CustomerFullName:54
		[eWires:13]ToAmount:14:=vAmount
		[eWires:13]Currency:12:=vCurrency
		//[eWires]ForeignAccount:=getAgentPendingAccountID ([eWires]AuthorizedUser;[eWires]isPaymentSent;vCurrency)  ` payable account
		[eWires:13]fromCountryCode:111:=<>COUNTRYCODE
		[eWires:13]fromCountry:9:=<>COMPANYCOUNTRY
		[eWires:13]PurposeOfTransaction:65:=[Invoices:5]AMLPurposeOfTransaction:85
		[eWires:13]AMLsourceOfFunds:94:=[Invoices:5]SourceOfFund:68
	Else 
		[eWires:13]FromAmount:13:=vAmount
		[eWires:13]FromCurrency:11:=vCurrency
		//[eWires]ForeignAccount:=getAgentPendingAccountID ([eWires]AuthorizedUser;[eWires]isPaymentSent;[eWires]ToCurrency;vCurrency)  ` receivable account
		//[eWires]toCountry:=<>COMPANYCOUNTRY// commented out in ver. 4.361 by TB
	End if 
	
	arrPartnerBank:=0
	//unloadRecordBanks 
	
End if 

C_LONGINT:C283($switch; rb1; b2; rb3; rb4; rb5)
C_BOOLEAN:C305($isPaid; $isReceived)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
C_TEXT:C284($currency; vCurrency)

$isReceived:=Not:C34($isPaymentSent)
$isPaid:=Not:C34($isReceived)
If ($isReceived)
	$currency:=[eWires:13]FromCurrency:11
	$amountPtr:=->[eWires:13]FromAmount:13
Else 
	$currency:=[eWires:13]Currency:12
	$amountPtr:=->[eWires:13]ToAmount:14
End if 
$ratePtr:=->[eWires:13]sourceRate:41
$percentPtr:=->[eWires:13]sourcePCTFee:43
$feeLocalPtr:=->[eWires:13]sourceServicefeeLocal:44
$amountLocalPtr:=->[eWires:13]amountLocal:45
$amountLocalBFPtr:=->vAmountLocal_BF
$percentFeeLocalPtr:=->vPercentFeeLocal
$totalFeesPtr:=->vTotalFees
$inverseRatePtr:=->vInverseRate

If (Form event code:C388=On Load:K2:1)
	setRadioButtonStatesInInvoice(5)
	setEnterableIff(isUserManager; "amendedName")
	vBaseCurrency:=<>baseCurrency
End if 

$switch:=getRadioButtonsSelection(rb1; rb2; rb3; rb4; rb5)

//NEED TO LOCK WHEN USING WEBEWIRES RECORD

If ([eWires:13]WebEwireID:123="")  //dont update if created from webewires
	calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
Else 
	OBJECT SET ENTERABLE:C238(*; "toAmount"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "CalcField8"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "vInverseRate1"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "calcField1"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "CalcField_2"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "CalcField9"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "vTotalFees1"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "CalcField11"; False:C215)
	OBJECT SET ENTERABLE:C238(*; "vTotalFees1"; False:C215)
	
	OBJECT SET ENABLED:C1123(*; "radio button@"; False:C215)
	
	vBaseCurrency:=[eWires:13]FromCurrency:11
End if 


If (Form event code:C388=On Load:K2:1)  // both for modification and new record
	selectLinksByCustIDnCountry
	clearPictureField(->latestListCheckBeneficiary4)
	clearPictureField(->latestListCheckBeneficiary5)
	clearPictureField(->latestListCheckBeneficiary8)
End if 

handleCloseBox