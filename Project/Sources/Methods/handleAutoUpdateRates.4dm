//%attributes = {}
C_TEXT:C284(vHTML)
vHTML:=""
//vHTML:=getYahooQuotesHTML ([Currencies]Symbol;◊baseCurrency) `   THIS IS UPDATED***

//If ([Currencies]AutoUpdateOurRates)
//
//C_REAL($normalizer)
//$normalizer:=100000
//vHTML:=getYahooQuotesHTML ([Currencies]ISO4217;[Currencies]toISO4217;$normalizer)
//
//If (vHTML#"")
//parseQuoteFieldsFromYahoo (->vHTML;$normalizer)
//  `CALL PROCESS(Current process)
//End if 
//
//SET VISIBLE(*;"updateOval@";False)
//Else 
//ALERT("Automatic Update is off")
//End if 

If (Not:C34(updateSpotRate))
	myAlert("Couldn't update the spot rate.")
End if 