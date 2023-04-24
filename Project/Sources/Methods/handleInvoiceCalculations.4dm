//%attributes = {}
C_LONGINT:C283($switch)
C_BOOLEAN:C305($isReceived)
C_REAL:C285(vRate; vAmount; vFeelLocal; vAmountLocal)
ARRAY TEXT:C222(vPaymentMethod; 6)  // redeclaring the payment method array
C_TEXT:C284(INV_vNextAccountID)

Case of 
	: (rb1=1)  //vAmount
		$switch:=1
		//calcvAmount 
	: (rb2=1)  // vRate
		$switch:=2
		//calcvRate 
	: (rb3=1)  //vPercentFee
		$switch:=3
		//calcvPercentFee 
	: (rb4=1)  // vFeeLocal
		$switch:=4
		//calcvFeeLocal 
	: (rb5=1)  // vAmountLocal
		$switch:=5
		//calcvAmountLocal 
End case 
$isReceived:=(vReceivedOrPaid=c_Received)

C_BOOLEAN:C305($matchFeeRule; $matchAMLRule)

// calculation of fields has to be done once before the rule matching and once again after the rule matching was done -- BUG REPORTED BY HOUMAN --  

calculateFieldsInInvoiceRows($switch; $isReceived; vCurrency; ->vAmount; ->vRate; ->vPercentFee; ->vfeeLocal; ->vamountLocal; ->vamountLocal_BF; ->vPercentFeeLocal; ->vTotalFees; ->vInverseRAte)

Case of 
	: ((isUserAllowedToEditFees) & (cbEditFees=1))  // if user is allowed to edit the fees and willing to do so, then disable the matching rules
		$matchFeeRule:=False:C215
	: (getKeyValue("invoices.useRateRules"; "false")="true")
		$matchFeeRule:=False:C215  // use fee from raterules
	Else 
		$matchFeeRule:=matchFeeRules(vReceivedorPaid; vecPaymentMethod{vecPaymentMethod}; INV_vNextAccountID; vAmount; vCurrency; vAmountLocal; ->vFeeLocal; ->vPercentFee; ->cbFeeStructure{0}; vCustomerGroup)
End case 
setVisibleIff($matchFeeRule; "FeeFrame")

calculateFieldsInInvoiceRows($switch; $isReceived; vCurrency; ->vAmount; ->vRate; ->vPercentFee; ->vfeeLocal; ->vamountLocal; ->vamountLocal_BF; ->vPercentFeeLocal; ->vTotalFees; ->vInverseRAte)


If ($switch=2)
	setvRate
End if 


//calcvAmountLocal_BF 
calcFeesInInvoice

normalizeVarsInInvoice
