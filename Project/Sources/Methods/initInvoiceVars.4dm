//%attributes = {}
C_BOOLEAN:C305($1; $getInvoiceID)  //@ibb so only for NEW records


C_REAL:C285(vSpotRate; vSpotRateInv; vBuyRate; vBuyRateInv; vSellRate; vSellRateInv; vRate; vInverseRate)
C_REAL:C285(vAmount; vAmountLocal; vFee; vFeeLocal; vAmountLocal_BF; vPercentFeeLocal; vPercentFee; vTotalFeesLocal)
C_REAL:C285(vSumTotalFees; vFromAmount; vToAmount; vSumDebitsLocal; vSumCreditsLocal)

ARRAY TEXT:C222(vecCurrency; 1)
ARRAY TEXT:C222(cbFeeStructure; 6)
C_TEXT:C284(vCurrency; vFromCurrency; vToCurrency; vInvoiceNumber)
C_DATE:C307(vInvoiceDate)
C_TIME:C306(vInvoicetime)
C_PICTURE:C286(vFromFlag; vToFlag; vCurrencyFlag)
C_LONGINT:C283(rb1; rb2; rb3; rb4; rb5)
setRadioButtonStatesInInvoice(5)

If (Count parameters:C259>=1)
	$getInvoiceID:=$1
Else 
	$getInvoiceID:=True:C214
End if 

If ($getInvoiceID)
	vInvoiceNumber:=makeInvoiceID
Else 
	vInvoiceNumber:=""  // will get from field
End if 

setReceivedOrPaid(0)
fillCurrencyCodeArray(->vecCurrency)

initVecPaymentMethod

vCurrency:=""
vFromCurrency:=""
vToCurrency:=""

vSpotRate:=0
vSpotRateInv:=0
vBuyRate:=0
vBuyRateInv:=0
vSellRate:=0
vSellRateInv:=0
vAmount:=0
vAmountLocal_BF:=0
vAmountLocal:=0

vFee:=0
vFeeLocal:=0
vPercentFee:=0
vPercentFeeLocal:=0
vTotalFeesLocal:=0
vRate:=0
vInverseRate:=0

vSumDebitsLocal:=0
vSumCreditsLocal:=0

vSumTotalFees:=0

vFromAmount:=0
vToAmount:=0

vInvoiceDate:=Current date:C33
vInvoiceTime:=Current time:C178

clearPictureField(->vFromFlag)
clearPictureField(->vToFlag)
clearPictureField(->vCurrencyFlag)

//setvCustomerID (getNextCustomer )
//initNextCustomer 
