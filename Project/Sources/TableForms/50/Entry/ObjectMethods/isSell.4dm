If (Form event code:C388=On Clicked:K2:4)
	setExchangeRate(->[Bookings:50]ourRate:11; ->[Bookings:50]inverseRate:29; getReceivedOrPayString(Num:C11(Not:C34([Bookings:50]isSell:7))); [Currencies:6]OurBuyRateLocal:7; [Currencies:6]OurSellRateLocal:8; True:C214)
	
End if 
