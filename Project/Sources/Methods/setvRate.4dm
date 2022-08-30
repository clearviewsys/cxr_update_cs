//%attributes = {}
setExchangeRate(->vRate; ->vInverseRate; vReceivedOrPaid; vBuyRate; vSellRate)

//If (isRateOffRange (vSpotRate;vRate))
//ALERT("This rate differs more than "+String(◊errorTolerance*100;"|Percent")+" from the system rate ("+String(vSpotRate)+")")
//End if 