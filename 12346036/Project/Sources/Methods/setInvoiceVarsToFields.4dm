//%attributes = {}


// ******** THESE TWO LINES ARE NOW OBSOLETE 
// *********** BACKWARD COMPATIBILITY IS LOST VERSION 128 (APR 15, 2004)

//vFromAmount:=[Invoices]AmountReceivedCAD+[Invoices]CurrencyBought  ` one of these value is zero
//vToAmount:=[Invoices]TotalCurrencySold+[Invoices]TotalBoughtAmountCAD  ` one of these values is zero
C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vExchangeRateAvg; vServiceFee; vForeignFee; vPercentFee)
C_DATE:C307(vInvoiceDate)
C_TEXT:C284(vFeeStructureID; vFromCurrency; vToCurrency; vInvoiceNumber; vCustomerID)

vFromCurrency:=[Invoices:5]fromCurrency:3
vToCurrency:=[Invoices:5]toCurrency:8
vInvoiceDate:=[Invoices:5]invoiceDate:44

vInvoiceNumber:=[Invoices:5]InvoiceID:1
vCustomerID:=[Invoices:5]CustomerID:2

RELATE ONE:C42([Invoices:5]CustomerID:2)

vFromAmount:=[Invoices:5]fromAmount:25
vToAmount:=[Invoices:5]toAmount:26

vExchangeRate:=[Invoices:5]ExchangeRate:21
vFromOurBuy:=[Invoices:5]PolicyRateBuy:5
vToOurSell:=[Invoices:5]PolicyRateSell:10
vRate1:=[Invoices:5]BuyRate:36
vRate2:=[Invoices:5]SellRate:37


vFromMarketAvg:=[Invoices:5]SpotRateBuy:33
vToMarketAvg:=[Invoices:5]SpotRateSell:35
vExchangeRateAvg:=calcSafeDivide([Invoices:5]SpotRateBuy:33; [Invoices:5]SpotRateSell:35)  // this is the market exchange

vOurExchangeRate:=[Invoices:5]ExchangeRate:21

vServiceFee:=[Invoices:5]feeLocal:6
vForeignFee:=[Invoices:5]ForeignFee:27
vPercentFee:=[Invoices:5]PercentFee:28
cbFeePaidSeparately:=Num:C11([Invoices:5]ThirdPartyisInvolved:22)


//[Invoices]ThirdPartyisInvolved:=False

setFlagPicture(->vFromFlag; [Invoices:5]fromCurrency:3)
setFlagPicture(->vToFlag; [Invoices:5]toCurrency:8)
