HandleEntryFormMethod

If (Form event code:C388=On Load:K2:1)
	[Items:39]Currency:8:=<>BASECURRENCY  // assuming most of the time the items are in base currency
	
	If ([Items:39]isService:5)
		[Items:39]isTax1forBuy:14:=True:C214
		[Items:39]isTax1ForSell:16:=True:C214
		[Items:39]isTax2ForBuy:15:=False:C215
		[Items:39]isTax2ForSell:17:=False:C215
	Else 
		[Items:39]isTax1forBuy:14:=True:C214
		[Items:39]isTax1ForSell:16:=True:C214
		[Items:39]isTax2ForBuy:15:=True:C214
		[Items:39]isTax2ForSell:17:=True:C214
	End if 
End if 

