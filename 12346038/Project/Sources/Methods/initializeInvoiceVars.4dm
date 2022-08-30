//%attributes = {}
C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vServiceFee; vForeignFee; vPercentFee)
C_DATE:C307(vInvoiceDate)
C_TEXT:C284(vFromCurrency; vToCurrency; vInvoiceNumber)

vRemainReceive:=0
vRemainPaid:=0
vCrossExchangeRate:=0
vTotalReceived:=0
vTotalPaid:=0

vOurExchangeRate:=0
vExchangeRateAvg:=0



vFromCurrency:=""
vToCurrency:=""
vInvoiceDate:=Current date:C33
//vInvoiceNumber:="" 
vCustomerID:=""

vFromAmount:=0
vToAmount:=0

vExchangeRate:=0
vFromOurBuy:=0
vToOurSell:=0

vServiceFee:=0
vForeignFee:=0
vPercentFee:=0

cbFeePaidSeparately:=0

C_REAL:C285(vForeignFeeInCAD; vCommissionInCAD; vExchangeDiffInCAD; vTotalFeesInCAD)
vForeignFeeInCAD:=0
vCommissionInCAD:=0
vExchangeDiffInCAD:=0
vTotalFeesInCAD:=0