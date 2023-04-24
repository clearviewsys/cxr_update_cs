//%attributes = {}
C_REAL:C285(vFromMarketAvg; vToMarketAvg; vExchangeRateAvg; vFromAmount; vToAmount; vExchangeRate; vServiceFee; vForeignFee; vPercentFee)

vFromAmount:=0
vToAmount:=0
vExchangeRate:=0
vServiceFee:=0
vForeignFee:=0
vPercentFee:=0

C_REAL:C285(vRate1; vRate2; vFromMarketAvg; vToMarketAvg; vFromOurBuy; vToOurSell; vInverseRate)

vRate1:=0
vRate2:=0
vFromMarketAvg:=0
vToMarketAvg:=0
vFromOurBuy:=0
vToOurSell:=0
vInverseRate:=0

loadPictureResource("flag_NULL"; ->vFromFlag)
//GET PICTURE FROM LIBRARY("flag_NULL"; vFromFlag)
loadPictureResource("flag_NULL"; ->vToFlag)
//GET PICTURE FROM LIBRARY("flag_NULL"; vToFlag)

setCrossCheckBoxFromLegPolicies